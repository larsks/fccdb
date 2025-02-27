create table entity (
record_type char(2),
unique_system_identifier integer primary key,
uls_file_number char(14),
ebf_number varchar(30),
call_sign char(10),
entity_type char(2),
licensee_id char(9),
entity_name varchar(200),
first_name varchar(20),
mi char(1),
last_name varchar(20),
suffix char(3),
phone char(10),
fax char(10),
email varchar(50),
street_address varchar(60),
city varchar(20),
state char(2),
zip_code char(9),
po_box varchar(20),
attention_line varchar(35),
sgin char(3),
fcc_registration_number char(10),
applicant_type_code char(1),
applicant_type_code_other char(40),
status_code char(1),
status_date text,
ghz_license_type char(1),
linked_unique_system_identifier integer,
linked_call_sign char(10)
);

create table amateur (
record_type char(2),
unique_system_identifier integer primary key
	references entity(unique_system_identifier),
uls_file_number char(14),
ebf_number varchar(30),
call_sign char(10),
operator_class char(1),
group_code char(1),
region_code tinyint,
trustee_call_sign char(10),
trustee_indicator char(1),
physician_certification char(1),
ve_signature char(1),
systematic_call_sign_change char(1),
vanity_call_sign_change char(1),
vanity_relationship char(12),
previous_call_sign char(10),
previous_operator_class char(1),
trustee_name varchar(50)
);

create table history (
record_type char(2),
unique_system_identifier integer
	references entity(unique_system_identifier),
uls_file_number char(14),
call_sign char(10),
log_date text,
code char(6)
);

create index entity_callsign_index on entity (call_sign);
create index amateur_callsign_index on amateur (call_sign);
create index history_usi_index on history (unique_system_identifier);
create index history_callsign_index on history (call_sign);
