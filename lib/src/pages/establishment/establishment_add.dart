import 'package:attendance_nmscst/src/pages/establishment/modules/button_footer.dart';
import 'package:attendance_nmscst/src/pages/establishment/modules/title_header.dart';
import 'package:attendance_nmscst/src/pages/map/google_map.dart';
import 'package:attendance_nmscst/src/utils/styles/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EstablishmentAdd extends StatefulWidget {
  const EstablishmentAdd({super.key});

  @override
  State<EstablishmentAdd> createState() => _EstablishmentAddState();
}

class _EstablishmentAddState extends State<EstablishmentAdd> {
  final bool _default = true;
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, minWidth: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          establishmentTitleHeader(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _default && !_show
                      ? TextFormField(
                          // controller: _locationController,
                          readOnly: true,
                          // decoration: UtilsTextField.design.copyWith(
                          //     hintText: UserSession.location == ""
                          //         ? 'Address'
                          //         : UserSession.location),
                        )
                      : const SizedBox(),
                  _default && !_show
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            // controller: _controllController,
                            decoration: UtilsTextField.design
                                .copyWith(labelText: 'Establishment name'),
                          ),
                        )
                      : const SizedBox(),
                  _default && !_show
                      ? TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // controller: _hoursController,
                          decoration: UtilsTextField.design
                              .copyWith(labelText: 'Hours Required'),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  _default && !_show
                      ? TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // controller: _radiusController,
                          decoration: UtilsTextField.design
                              .copyWith(labelText: 'Radius (default 5 meters)'),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: IconButton(
                        color: Colors.redAccent,
                        iconSize: 50,
                        icon: const Icon(Icons.location_pin),
                        onPressed: () async {
                          final value = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapScreen()),
                          );
                          if (value != null) {
                            setState(() {
                              _show = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Click the icon to register Location"),
                  ),
                  _default && !_show
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                // checkTextField();
                              },
                              child: const Icon(Icons.save)))
                      : const SizedBox()
                ],
              ),
            ),
          ),
          establishmentButtonFooter(context),
        ],
      ),
    );
  }
}
