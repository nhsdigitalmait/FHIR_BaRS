SCRIPT 111_uec_200000000359
# Generated automatically on: Wed Jul 21 15:53:39 BST 2021
# Merged Files:
# TKW_ROOT/config/FHIR_BaRS/autotest_config/tstp/EB_Common.tstp
# TKW_ROOT/config/FHIR_BaRS/autotest_config/tstp/EB_Capability.tstp

SIMULATOR TKW_ROOT/config/FHIR_BaRS/simulator_config/test_tks_rule_config.txt

VALIDATOR TKW_ROOT/config/FHIR_BaRS/validator_config/consumer_simulator_validator.conf

STOP WHEN COMPLETE

BEGIN SCHEDULES
Capability_xml_accept TESTS CapabilityTest_xml_accept ResponseIsCapabilityStatement ResponseIsXml
Capability_json_accept TESTS CapabilityTest_json_accept ResponseIsCapabilityStatement ResponseIsJson
Capability_xml_parameter TESTS CapabilityTest_xml_parameter ResponseIsCapabilityStatement ResponseIsXml
Capability_json_parameter TESTS CapabilityTest_json_parameter ResponseIsCapabilityStatement ResponseIsJson
Capability_xml_parameter_json_accept TESTS CapabilityTest_xml_parameter_json_accept ResponseIsCapabilityStatement ResponseIsXml
Capability_json_parameter_xml_accept TESTS CapabilityTest_json_parameter_xml_accept ResponseIsCapabilityStatement ResponseIsJson
Capability_xml_accept_gzip TESTS CapabilityTest_xml_accept_gzip ResponseIsCapabilityStatement ResponseIsXml ResponseWasGzip
END SCHEDULES

BEGIN TESTS
AccessDenied CHAIN SYNC access_denied TEXT "Response contains a root fhir:OperationOutcome reporting an ACCESS DENIED code"
AppointmentIsBooked CHAIN SYNC appt_is_booked TEXT "Appointment status must be booked SCAL C-APP-RES-STAT-BOOKED"
BadRequest CHAIN SYNC bad_request TEXT "Response contains a root fhir:OperationOutcome reporting an BAD_REQUEST code"
BookAppointment SEND_TKW book_appointment_slot5 TO /Appointment FROM http://127.0.0.1:4000 PRETRANSFORM TKW_ROOT/config/FHIR_BaRS/autotest_config/transforms/remove_appt_id.xslt APPLYPRETRANSFORMTO data SYNC httpstatuscheck201 WITH_PROPERTYSET base+webservices+post WITH_HTTPHEADERS credentials+book_appt_interactionid+JWT_book_cancel+default_content+default_accept+integrity TEXT "HTTP Response must be HTTP 201"
CapabilityTest_json_accept SEND_TKW empty_file TO /metadata FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata+json_accept TEXT "HTTP Response must be HTTP 200"
CapabilityTest_json_parameter SEND_TKW empty_file TO /metadata?_format=application/fhir%2Bjson FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata TEXT "HTTP Response must be HTTP 200"
CapabilityTest_json_parameter_xml_accept SEND_TKW empty_file TO /metadata?_format=application/fhir%2Bjson FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata+xml_accept TEXT "HTTP Response must be HTTP 200"
CapabilityTest_xml_accept SEND_TKW empty_file TO /metadata FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata+xml_accept TEXT "HTTP Response must be HTTP 200"
CapabilityTest_xml_accept_gzip SEND_TKW empty_file TO /metadata FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata+xml_accept+accept_gzip TEXT "HTTP Response must be HTTP 200"
CapabilityTest_xml_parameter SEND_TKW empty_file TO /metadata?_format=application/fhir%2Bxml FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata TEXT "HTTP Response must be HTTP 200"
CapabilityTest_xml_parameter_json_accept SEND_TKW empty_file TO /metadata?_format=application/fhir%2Bxml FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+getmetadata_interactionid+JWT_metadata+json_accept TEXT "HTTP Response must be HTTP 200"
ConflictingValues CHAIN SYNC conflicting_values TEXT "Response contains a root fhir:OperationOutcome reporting an CONFLICTING_VALUES code"
IntegrityCorrelationIDHeaderIsPresent CHAIN SYNC response_has_correlation_id_header TEXT "Response contains a X-Correlation-ID header"
IntegrityHeadersMatch CHAIN SYNC integrity_headers_match TEXT "Request httpheader X-Request-ID matches response httpHeader X-Correlation-ID"
InternalServerError CHAIN SYNC internal_server_error TEXT "Response contains a root fhir:OperationOutcome reporting an INTERNAL_SERVER_ERROR code"
InvalidParameter CHAIN SYNC invalid_parameter TEXT "Response contains a root fhir:OperationOutcome reporting an INVALID_PARAMETER code"
LocationIsReturned CHAIN SYNC location_is_returned TEXT "Location must be returned in an http header"
MissingOrInvalidHeader CHAIN SYNC missing_or_invalid_header TEXT "Response contains a root fhir:OperationOutcome reporting an MISSING_OR_INVALID_HEADER code"
NoRecordFound CHAIN SYNC no_record_found TEXT "Response contains a root fhir:OperationOutcome reporting an NO_RECORD_FOUND code"
NotSupported CHAIN SYNC not_supported TEXT "Response contains a root fhir:OperationOutcome reporting an not-supported code"
OperationOutcomeSystemCodeIsSpine CHAIN SYNC operation_outcome_system_code_is_spine TEXT "OperationOutcome System code is https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1"
ReferenceNotFound CHAIN SYNC reference_not_found TEXT "Response contains a root fhir:OperationOutcome reporting an REFERENCE_NOT_FOUND code"
ResponseIsAppointmentExtracting20 CHAIN SYNC response_is_appt_extracting20 TEXT "Response contains a root fhir:Appointment element"
ResponseIsAppointmentExtracting5 CHAIN SYNC response_is_appt_extracting5 TEXT "Response contains a root fhir:Appointment element"
ResponseIsBundle CHAIN SYNC response_is_bundle TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting10 CHAIN SYNC response_is_bundle_extracting10 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting11 CHAIN SYNC response_is_bundle_extracting11 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting12 CHAIN SYNC response_is_bundle_extracting12 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting13 CHAIN SYNC response_is_bundle_extracting13 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting14 CHAIN SYNC response_is_bundle_extracting14 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting15 CHAIN SYNC response_is_bundle_extracting15 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting16 CHAIN SYNC response_is_bundle_extracting16 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting17 CHAIN SYNC response_is_bundle_extracting17 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting18 CHAIN SYNC response_is_bundle_extracting18 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting19 CHAIN SYNC response_is_bundle_extracting19 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting20 CHAIN SYNC response_is_bundle_extracting20 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting5 CHAIN SYNC response_is_bundle_extracting5 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting6 CHAIN SYNC response_is_bundle_extracting6 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting7 CHAIN SYNC response_is_bundle_extracting7 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting8 CHAIN SYNC response_is_bundle_extracting8 TEXT "Response contains a root fhir:Bundle element"
ResponseIsBundleExtracting9 CHAIN SYNC response_is_bundle_extracting9 TEXT "Response contains a root fhir:Bundle element"
ResponseIsCapabilityStatement CHAIN SYNC response_is_capability_statement TEXT "Response must be a CapabilityStatement"
ResponseIsEmptyPayloadExtracting13 CHAIN SYNC response_is_empty_payload_extracting13 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting14 CHAIN SYNC response_is_empty_payload_extracting14 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting15 CHAIN SYNC response_is_empty_payload_extracting15 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting16 CHAIN SYNC response_is_empty_payload_extracting16 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting17 CHAIN SYNC response_is_empty_payload_extracting17 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting18 CHAIN SYNC response_is_empty_payload_extracting18 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting19 CHAIN SYNC response_is_empty_payload_extracting19 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting20 CHAIN SYNC response_is_empty_payload_extracting20 TEXT "Response payload is empty"
ResponseIsEmptyPayloadExtracting5 CHAIN SYNC response_is_empty_payload_extracting5 TEXT "Response payload is empty"
ResponseIsJson CHAIN SYNC httpheadercheckcontenttypeisjson TEXT "Response has fhir json Content-type"
ResponseIsOperationOutcome CHAIN SYNC operation_outcome TEXT "Response contains a root fhir:OperationOutcome element"
ResponseIsXml CHAIN SYNC httpheadercheckcontenttypeisxml TEXT "Response has fhir xml Content-type"
ResponseWasGzip CHAIN SYNC response_has_was_gzip_header TEXT "Response was returned with a Content-encoding http header value of gzip"
SFFSWithValidParameters_3_days SEND_TKW empty_file TO /Slot?schedule.actor%3Ahealthcareservice=__HCS__&start=ge__START_SLOT_TIME__&start=le__END_SLOT_TIME__&status=free&_include=Slot%3Aschedule&_include=Schedule%3Aactor%3APractitioner&_include=Schedule%3Aactor%3APractitionerRole&_include=Schedule%3Aactor%3AHealthcareService&_include=HealthcareService.location&_include=HealthcareService.providedBy FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+default_accept+search_slots_interactionid+JWT_search_slots TEXT "HTTP Response must be HTTP 200"
SFFSWithValidParameters_3_days_5 SEND_TKW empty_file5 TO /Slot?schedule.actor%3Ahealthcareservice=__HCS__&start=ge__START_SLOT_TIME__&start=le__END_SLOT_TIME__&status=free&_include=Slot%3Aschedule&_include=Schedule%3Aactor%3APractitioner&_include=Schedule%3Aactor%3APractitionerRole&_include=Schedule%3Aactor%3AHealthcareService&_include=HealthcareService.location&_include=HealthcareService.providedBy FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+default_accept+search_slots_interactionid+JWT_search_slots TEXT "HTTP Response must be HTTP 200"
SFFSWithValidParameters_3_days_slots_only SEND_TKW empty_file TO /Slot?schedule.actor%3Ahealthcareservice=__HCS_SLOTS_ONLY__&start=ge__START_SLOT_TIME__&start=le__END_SLOT_TIME__&status=free&_include=Slot%3Aschedule&_include=Schedule%3Aactor%3APractitioner&_include=Schedule%3Aactor%3APractitionerRole&_include=Schedule%3Aactor%3AHealthcareService&_include=HealthcareService.location&_include=HealthcareService.providedBy FROM http://127.0.0.1:4000 SYNC ok WITH_PROPERTYSET base+webservices+get WITH_HTTPHEADERS credentials+default_accept+search_slots_interactionid+JWT_search_slots TEXT "HTTP Response must be HTTP 200"
UnsupportedMediaType CHAIN SYNC unsupported_media_type TEXT "Response contains a root fhir:OperationOutcome reporting an UNSUPPORTED_MEDIA_TYPE code"
END TESTS

BEGIN MESSAGES
book_appointment_slot20 USING book_appt_template WITH slots20 ID s20
book_appointment_slot5 USING book_appt_template WITH slots5 ID s5
empty_file USING empty_file_template WITH slots
empty_file10 USING empty_file_template WITH slots10 ID s10
empty_file11 USING empty_file_template WITH slots11 ID s11
empty_file12 USING empty_file_template WITH slots12 ID s12
empty_file13 USING empty_file_template WITH slots13 ID s13
empty_file14 USING empty_file_template WITH slots14 ID s14
empty_file15 USING empty_file_template WITH slots15 ID s15
empty_file16 USING empty_file_template WITH slots16 ID s16
empty_file17 USING empty_file_template WITH slots17 ID s17
empty_file18 USING empty_file_template WITH slots18 ID s18
empty_file19 USING empty_file_template WITH slots19 ID s19
empty_file20 USING empty_file_template WITH slots20 ID s20
empty_file5 USING empty_file_template WITH slots5 ID s5
empty_file6 USING empty_file_template WITH slots6 ID s6
empty_file7 USING empty_file_template WITH slots7 ID s7
empty_file8 USING empty_file_template WITH slots8 ID s8
empty_file9 USING empty_file_template WITH slots9 ID s9
END MESSAGES

BEGIN TEMPLATES
book_appt_template TKW_ROOT/config/FHIR_BaRS/autotest_config/requests/book_appt.xml
empty_file_template TKW_ROOT/config/FHIR_BaRS/autotest_config/requests/emptyfile.txt
END TEMPLATES

BEGIN PROPERTYSETS
get
	SET tks.transmitter.http.method GET
post
	SET tks.transmitter.http.method POST
put
	SET tks.transmitter.http.method PUT
webservices
	SET tks.HttpTransport.listenport 4000
	SET tks.HttpTransport.listenaddr  127.0.0.1
	SET tks.tls.truststore NONE
	SET tks.tls.keystore NONE
	SET tks.sendtls No
	SET tks.fhir.version Dstu3
	SET tks.HttpTransport.suppress.close Y
	SET tks.transmitter.send.chunksize 0
	SET tks.autotest.stoponfail No
END PROPERTYSETS

BEGIN HTTPHEADERS
JWT_book_cancel
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template.book_cancel.fhir3.txt 111222333444 "" secret true
JWT_invalid_aud
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template.sffs.fhir3.txt 111222333444 notanendpoint secret true
JWT_metadata
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template_metadata.fhir3.txt 111222333444 "" secret true
JWT_read_appt
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template.read_appt.fhir3.txt 111222333444 "" secret true
JWT_search_slots
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template.sffs.fhir3.txt 111222333444 "" secret true
JWT_search_slots_no_practitioner
	Authorization function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getJWT TKW_ROOT/config/FHIR_BaRS/autotest_config/jwt_templates/111_uec_jwt_template.sffs.nopractitioner.fhir3.txt 111222333444 "" secret true
accept_gzip
	Accept-Encoding "gzip"
book_appt_interactionid
	Ssp-InteractionID "urn:nhs:names:services:careconnect:fhir:rest:create:appointment"
content_gzip
	Content-Encoding "gzip"
credentials
	Ssp-From "200000000359"
	Ssp-To "200000000359"
	Ssp-TraceID function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getuuid
default_accept
	Accept "application/fhir+json"
default_content
	Content-type "application/fhir+json"
getmetadata_interactionid
	Ssp-InteractionID "urn:nhs:names:services:careconnect:fhir:rest:read:metadata"
integrity
	X-Request-ID function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getuuid
json_accept
	Accept "application/fhir+json"
json_content
	Content-type "application/fhir+json"
read_appt_interactionid
	Ssp-InteractionID "urn:nhs:names:services:careconnect:fhir:rest:read:appointment"
resent_rq_id
	X-Request-ID __CORRELATION_ID__
search_slots_interactionid
	Ssp-InteractionID "urn:nhs:names:services:careconnect:fhir:rest:search:slot"
unsupported_content
	Content-type "application/xml"
update_appt_interactionid
	Ssp-InteractionID "urn:nhs:names:services:careconnect:fhir:rest:update:appointment"
xml_accept
	Accept "application/fhir+xml"
xml_content
	Content-type "application/fhir+xml"
END HTTPHEADERS

BEGIN DATASOURCES
slots circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots.tdv
slots10 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_10.tdv
slots11 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_11.tdv
slots12 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_12.tdv
slots13 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_13.tdv
slots14 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_14.tdv
slots15 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_15.tdv
slots16 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_16.tdv
slots17 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_17.tdv
slots18 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_18.tdv
slots19 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_19.tdv
slots20 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_20.tdv
slots5 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_5.tdv
slots6 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_6.tdv
slots7 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_7.tdv
slots8 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_8.tdv
slots9 circularwritabletdv TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slot_9.tdv
END DATASOURCES

BEGIN EXTRACTORS
slots_free10_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free10.cfg
slots_free11_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free11.cfg
slots_free12_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free12.cfg
slots_free13_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free13.cfg
slots_free14_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free14.cfg
slots_free15_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free15.cfg
slots_free16_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free16.cfg
slots_free17_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free17.cfg
slots_free18_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free18.cfg
slots_free19_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free19.cfg
slots_free20_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free20.cfg
slots_free5_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free5.cfg
slots_free6_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free6.cfg
slots_free7_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free7.cfg
slots_free8_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free8.cfg
slots_free9_extractor xpathextractor TKW_ROOT/config/FHIR_BaRS/autotest_config/extractor_configs/slots_free9.cfg
END EXTRACTORS

BEGIN PASSFAIL
access_denied synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^ACCESS DENIED$"
appt_is_booked  synchronousxpath /fhir:Appointment/fhir:status/@value matches "^booked$"
bad_request synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^BAD_REQUEST$"
capability_format_json synchronousxpath /fhir:CapabilityStatement/fhir:format[matches(@value,'^.*json.*$')]/@value matches "^(application/fhir\+json|json)$"
capability_format_xml synchronousxpath /fhir:CapabilityStatement/fhir:format[matches(@value,'^.*xml.*$')]/@value matches "^(application/fhir\+xml|xml)$"
capability_software_name synchronousxpath /fhir:CapabilityStatement/fhir:software/fhir:name exists
capability_software_version synchronousxpath /fhir:CapabilityStatement/fhir:software/fhir:version exists
conflicting_values synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^CONFLICTING_VALUES$"
httpheadercheckchunking  httpheadercheck X-was-Transfer-Encoding matches  "^.*chunked.*$"
httpheadercheckcontentlengthcheck httpheadercheck Content-Length check
httpheadercheckcontentlengthdoesnotexist httpheadercheck Content-Length doesnotexist
httpheadercheckcontentlengthexists httpheadercheck Content-Length exists
httpheadercheckcontenttypeisjson  httpheadercheck Content-Type matches "^application/fhir\+json.*$"
httpheadercheckcontenttypeisxml  httpheadercheck Content-Type matches "^application/fhir\+xml.*$"
httpheaderchecknonzerocontent httpheadercheck Content-Length doesnotmatch "^0$"
httpheadercheckzerocontent httpheadercheck Content-Length matches "^0$"
httpstatuscheck201 httpstatuscheck 201
httpstatuscheck400 httpstatuscheck 400
httpstatuscheck403 httpstatuscheck 403
httpstatuscheck404 httpstatuscheck 404
httpstatuscheck405 httpstatuscheck 405
httpstatuscheck409 httpstatuscheck 409
httpstatuscheck412 httpstatuscheck 412
httpstatuscheck415 httpstatuscheck 415
httpstatuscheck422 httpstatuscheck 422
httpstatuscheck500 httpstatuscheck 500
httpstatuscheck502 httpstatuscheck 502
httpstatuscheck504 httpstatuscheck 504
httpstatuschecknot200 not ( httpok )
integrity_headers_match httpheadercorrelationcheck X-Request-ID X-Correlation-ID
internal_server_error synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^INTERNAL_SERVER_ERROR$"
invalid_parameter synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^INVALID_PARAMETER$"
location_is_returned httpheadercheck Location exists
missing_or_invalid_header synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^MISSING_OR_INVALID_HEADER$"
no_record_found synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^NO_RECORD_FOUND$"
not_supported synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:code/@value matches "^not-supported$"
ok httpok
operation_outcome synchronousxpath /fhir:OperationOutcome exists
operation_outcome_system_code_is_spine synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:system/@value matches "^https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1$"
reference_not_found synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^REFERENCE_NOT_FOUND$"
response_has_correlation_id_header httpheadercheck X-Correlation-ID exists
response_has_was_gzip_header httpheadercheck X-was-Content-Encoding matches "^gzip$"
response_is_appt_extracting20 synchronousxpath /fhir:Appointment exists EXTRACTOR slots_free20_extractor
response_is_appt_extracting5 synchronousxpath /fhir:Appointment exists EXTRACTOR slots_free5_extractor
response_is_bundle synchronousxpath /fhir:Bundle exists
response_is_bundle_extracting10 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free10_extractor
response_is_bundle_extracting11 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free11_extractor
response_is_bundle_extracting12 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free12_extractor
response_is_bundle_extracting13 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free13_extractor
response_is_bundle_extracting14 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free14_extractor
response_is_bundle_extracting15 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free15_extractor
response_is_bundle_extracting16 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free16_extractor
response_is_bundle_extracting17 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free17_extractor
response_is_bundle_extracting18 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free18_extractor
response_is_bundle_extracting19 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free19_extractor
response_is_bundle_extracting20 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free20_extractor
response_is_bundle_extracting5 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free5_extractor
response_is_bundle_extracting6 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free6_extractor
response_is_bundle_extracting7 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free7_extractor
response_is_bundle_extracting8 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free8_extractor
response_is_bundle_extracting9 synchronousxpath /fhir:Bundle exists EXTRACTOR slots_free9_extractor
response_is_capability_statement synchronousxpath /fhir:CapabilityStatement exists
response_is_empty_payload_extracting13 synchronousxpath / doesnotexist EXTRACTOR slots_free13_extractor
response_is_empty_payload_extracting14 synchronousxpath / doesnotexist EXTRACTOR slots_free14_extractor
response_is_empty_payload_extracting15 synchronousxpath / doesnotexist EXTRACTOR slots_free15_extractor
response_is_empty_payload_extracting16 synchronousxpath / doesnotexist EXTRACTOR slots_free16_extractor
response_is_empty_payload_extracting17 synchronousxpath / doesnotexist EXTRACTOR slots_free17_extractor
response_is_empty_payload_extracting18 synchronousxpath / doesnotexist EXTRACTOR slots_free18_extractor
response_is_empty_payload_extracting19 synchronousxpath / doesnotexist EXTRACTOR slots_free19_extractor
response_is_empty_payload_extracting5 synchronousxpath / doesnotexist EXTRACTOR slots_free5_extractor
type_searchset synchronousxpath /fhir:Bundle/fhir:type[@value='searchset'] exists
unsupported_media_type synchronousxpath /fhir:OperationOutcome/fhir:issue/fhir:details/fhir:coding/fhir:code/@value matches "^UNSUPPORTED_MEDIA_TYPE$"
END PASSFAIL

BEGIN SUBSTITUTION_TAGS
__END_SLOT_TIME__  function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getFormattedTime "yyyy-MM-dd'T00:00:00'XXX" "Europe/London" "4" "0" "true"
__HCS_400__  Literal "999999997"
__HCS_403__  Literal "999999996"
__HCS_405__  Literal "999999994"
__HCS_500__  Literal "999999995"
__HCS_NO_SLOTS__  Literal "999999998"
__HCS_SLOTS_ONLY__  Literal "999999993"
__HCS__  Literal "999999999"
__START_SLOT_TIME1L__  function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getFormattedTime "yyyy-MM-dd'T00:00:00'XXX" "Europe/London" "-1" "0" "true"
__START_SLOT_TIME__  function:uk.nhs.digital.mait.tkwx.tk.internalservices.testautomation.PropertySetFunctions.getFormattedTime "yyyy-MM-dd'T00:00:00'XXX" "Europe/London" "1" "0" "true"
END SUBSTITUTION_TAGS

