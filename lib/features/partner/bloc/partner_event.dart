import '../model/partner_form_model.dart';

abstract class PartnerEvent {}

class LoadCities extends PartnerEvent {}

class SubmitPartnerForm extends PartnerEvent {
  final PartnerFormModel form;

  SubmitPartnerForm(this.form);
}
