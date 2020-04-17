library flutter_google_places.src;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class Locator extends StatefulWidget {
  final String apiKey;
  final String startText;
  final String hint;
  final BorderRadius overlayBorderRadius;
  final Location location;
  final num offset;
  final num radius;
  final String language;
  final String sessionToken;
  final List<String> types;
  final List<Component> components;
  final bool strictbounds;
  final String region;
  final Widget logo;
  final ValueChanged<PlacesAutocompleteResponse> onError;
  final int debounce;

  /// optional - sets 'proxy' value in google_maps_webservice
  ///
  /// In case of using a proxy the baseUrl can be set.
  /// The apiKey is not required in case the proxy sets it.
  /// (Not storing the apiKey in the app is good practice)
  final String proxyBaseUrl;

  /// optional - set 'client' value in google_maps_webservice
  ///
  /// In case of using a proxy url that requires authentication
  /// or custom configuration
  final BaseClient httpClient;

  Locator(
      {@required this.apiKey,
      this.hint = "Search",
      this.overlayBorderRadius,
      this.offset,
      this.location,
      this.radius,
      this.language,
      this.sessionToken,
      this.types,
      this.components,
      this.strictbounds,
      this.region,
      this.logo,
      this.onError,
      Key key,
      this.proxyBaseUrl,
      this.httpClient,
      this.startText,
      this.debounce = 300})
      : super(key: key);

  @override
  State<Locator> createState() {
    return _LocatorAutoCompleteScaffoldState();
  }

  static LocatorAutocompleteState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<LocatorAutocompleteState>());
}

class _LocatorAutoCompleteScaffoldState extends LocatorAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: LocatorAutoCompleteTextField(),
    backgroundColor: Colors.amber[300],);
    final body = LocatorAutoCompleteResult(
      onTap: Navigator.of(context).pop,
      logo: widget.logo,
    );
    return Scaffold(appBar: appBar, body: body);
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 2.0),
        child: LinearProgressIndicator());
  }
}

class LocatorAutoCompleteResult extends StatefulWidget {
  final ValueChanged<Prediction> onTap;
  final Widget logo;

  LocatorAutoCompleteResult({this.onTap, this.logo});

  @override
  _PlacesAutocompleteResult createState() => _PlacesAutocompleteResult();
}

class _PlacesAutocompleteResult extends State<LocatorAutoCompleteResult> {
  @override
  Widget build(BuildContext context) {
    final state = Locator.of(context);
    assert(state != null);

    if (state._queryTextController.text.isEmpty ||
        state._response == null ||
        state._response.predictions.isEmpty) {
      final children = <Widget>[];
      if (state._searching) {
        children.add(_Loader());
      }
      return Stack(children: children);
    }
    return PredictionsListView(
      predictions: state._response.predictions,
      onTap: widget.onTap,
    );
  }
}

class LocatorAutoCompleteTextField extends StatefulWidget {
  @override
  _LocatorAutoCompleteTextFieldState createState() =>
      _LocatorAutoCompleteTextFieldState();
}

class _LocatorAutoCompleteTextFieldState
    extends State<LocatorAutoCompleteTextField> {
  @override
  Widget build(BuildContext context) {
    final state = Locator.of(context);
    assert(state != null);
    return Container(
        alignment: Alignment.topLeft,
        child: TextField(

          controller: state._queryTextController,
          autofocus: true,
          style: TextStyle(
            fontSize: 18.0,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: state.widget.hint,
            filled: true,
            fillColor: Colors.amber[100],
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
        ));
  }
}

class PredictionsListView extends StatelessWidget {
  final List<Prediction> predictions;
  final ValueChanged<Prediction> onTap;

  PredictionsListView({@required this.predictions, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: predictions
          .map((Prediction p) => PredictionTile(prediction: p, onTap: onTap))
          .toList(),
    );
  }
}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onTap;

  PredictionTile({@required this.prediction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: Text(prediction.description),
      onTap: () {
        if (onTap != null) {
          onTap(prediction);
        }
      },
    );
  }
}

abstract class LocatorAutocompleteState extends State<Locator> {
  TextEditingController _queryTextController;
  PlacesAutocompleteResponse _response;
  GoogleMapsPlaces _places;
  bool _searching;
  Timer _debounce;

  final _queryBehavior = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();
    _queryTextController = TextEditingController(text: widget.startText);

    _places = GoogleMapsPlaces(
        apiKey: widget.apiKey,
        baseUrl: widget.proxyBaseUrl,
        httpClient: widget.httpClient);
    _searching = false;

    _queryTextController.addListener(_onQueryChange);

    _queryBehavior.stream.listen(doSearch);
  }

  Future<Null> doSearch(String value) async {
    if (mounted && value.isNotEmpty) {
      setState(() {
        _searching = true;
      });

      final res = await _places.autocomplete(
        value,
        offset: widget.offset,
        location: widget.location,
        radius: widget.radius,
        language: widget.language,
        sessionToken: widget.sessionToken,
        types: widget.types,
        components: widget.components,
        strictbounds: widget.strictbounds,
        region: widget.region,
      );

      if (res.errorMessage?.isNotEmpty == true ||
          res.status == "REQUEST_DENIED") {
        onResponseError(res);
      } else {
        onResponse(res);
      }
    } else {
      onResponse(null);
    }
  }

  void _onQueryChange() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounce), () {
      _queryBehavior.add(_queryTextController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _places.dispose();
    _queryBehavior.close();
    _queryTextController.removeListener(_onQueryChange);
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    if (widget.onError != null) {
      widget.onError(res);
    }
    setState(() {
      _response = null;
      _searching = false;
    });
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    setState(() {
      _response = res;
      _searching = false;
    });
  }
}

class LocatorComplete {
  static Future<Prediction> show(
      {@required BuildContext context,
      @required String apiKey,
      String hint = "Search",
      BorderRadius overlayBorderRadius,
      num offset,
      Location location,
      num radius,
      String language,
      String sessionToken,
      List<String> types,
      List<Component> components,
      bool strictbounds,
      String region,
      Widget logo,
      ValueChanged<PlacesAutocompleteResponse> onError,
      String proxyBaseUrl,
      Client httpClient,
      String startText = ""}) {
    final builder = (BuildContext ctx) => Locator(
          apiKey: apiKey,
          overlayBorderRadius: overlayBorderRadius,
          language: language,
          sessionToken: sessionToken,
          components: components,
          types: types,
          location: location,
          radius: radius,
          strictbounds: strictbounds,
          region: region,
          offset: offset,
          hint: hint,
          logo: logo,
          onError: onError,
          proxyBaseUrl: proxyBaseUrl,
          httpClient: httpClient,
          startText: startText,
        );

    return Navigator.push(context, MaterialPageRoute(builder: builder));
  }
}
