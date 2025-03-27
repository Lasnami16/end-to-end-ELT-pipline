CREATE OR REPLACE EXTERNAL TABLE `wissem-school.raw_translations.translations`
OPTIONS (
  format = 'JSON',
  uris = ['gs://traduction_rapidos/translations/translations.json']
);


CREATE OR REPLACE EXTERNAL TABLE `wissem-school.raw_translations.clients`
OPTIONS (
  format = 'JSON',
  uris = ['gs://traduction_rapidos/translations/clients.json']
);

CREATE OR REPLACE EXTERNAL TABLE `wissem-school.raw_translations.documents`
OPTIONS (
  format = 'JSON',
  uris = ['gs://traduction_rapidos/translations/documents.json']
);

