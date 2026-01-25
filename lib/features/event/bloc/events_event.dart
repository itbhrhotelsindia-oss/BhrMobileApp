import '../model/event_enquiry_model.dart';

abstract class EventsEvent {}

class LoadEventsPage extends EventsEvent {}

class SubmitEventEnquiry extends EventsEvent {
  final EventEnquiryModel form;

  SubmitEventEnquiry(this.form);
}
