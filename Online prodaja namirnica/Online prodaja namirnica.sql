/*SQL Upiti za kreiranje baze podataka Online prodaja namirnica*/
CREATE DATABASE [Online prodaja namirnica]
GO
USE [Online prodaja namirnica]
GO
/* CREATE TABLE naredbe: */
CREATE TABLE FIRMA
(
pib int primary key NOT NULL,
naziv nvarchar(30) NOT NULL,
ulica_i_broj nvarchar(50) NULL,
ptt varchar(30) NULL
) 
GO
CREATE TABLE PRIPADA
(
url nvarchar(50) NOT NULL,
pib int NOT NULL
)
GO
CREATE TABLE "ONLINE PRODAVNICA"
(
url nvarchar(50)primary key NOT NULL,
web_stranica nvarchar(50) NULL,
inbox nvarchar(30) NOT NULL,
naziv nvarchar(15) NOT NULL,
domen nvarchar (30) NOT NULL
) 
GO
CREATE TABLE PRISTUPA
(
url nvarchar(50) NOT NULL,
jmbg bigint NOT NULL
)
GO
CREATE TABLE PRODAJE
(
url nvarchar(50) NOT NULL,
id_porudžbine int NOT NULL
)
GO
CREATE TABLE PORUČUJE
(
id_porudžbine int NOT NULL,
jmbg bigint NOT NULL,
url nvarchar(50) NOT NULL,
datum_porudžbine date NOT NULL
)
GO
CREATE TABLE "BOX PAKET"
(
id_porudžbine int primary key NOT NULL,
id_recepta int NOT NULL,
naziv nvarchar(15) NOT NULL,
cena money NOT NULL,
pdv decimal(10) NULL
)
GO
CREATE TABLE RECEPT
(
id_recepta int primary key NOT NULL,
naziv_sastojaka nvarchar(20) NULL,
količina nvarchar(5) NULL,
uputstvo nvarchar(50) NULL
)
GO
CREATE TABLE ČINE
(
id_porudžbine int NOT NULL,
šifra_namirnice int NOT NULL
)
GO
CREATE TABLE NAMIRNICE
(
šifra_namirnice int primary key NOT NULL,
naziv_namirnice nvarchar(15) NOT NULL,
gramaža nvarchar(30) NOT NULL
)
GO
CREATE TABLE "VEGANSKA JELA"
(
id_porudžbine int NOT NULL,
naziv_veganskog_jela nvarchar(30) NULL
)
GO
CREATE TABLE "TRADICIONALNA JELA"
(
id_porudžbine int NOT NULL,
naziv_regije nvarchar(20) NOT NULL
)
GO
CREATE TABLE "INTERNACIONALNA JELA"
(
id_porudžbine int NOT NULL,
naziv_države nvarchar(20) NOT NULL
) 
GO
CREATE TABLE "JELA ZA DIJABETIČARE"
(
id_porudžbine int NOT NULL,
zamenski_šećer nvarchar(20) NULL
)
GO
CREATE TABLE PREDAJE
(
pib int NOT NULL,
url nvarchar(50) NOT NULL,
id_porudžbine int NOT NULL,
datum_predaje date NOT NULL
)
GO
CREATE TABLE "KURIRSKA SLUŽBA"
(
pib int primary key NOT NULL,
naziv_firme nvarchar(15) NULL
)
GO
CREATE TABLE ISPORUČUJE
(
pib int NOT NULL,
jmbg bigint NOT NULL
)
GO
CREATE TABLE KORISNIK
(
jmbg bigint primary key NOT NULL,
ime nvarchar(30) NOT NULL,
prezime nvarchar(30) NOT NULL,
ulica_i_broj nvarchar(50) NOT NULL,
ptt varchar(30) NOT NULL
)
GO
CREATE TABLE MESTO
(
ptt varchar(30) primary key NOT NULL,
naziv_mesta nvarchar(15) NOT NULL
)
GO
/* ALTER TABLE naredbe: */
ALTER TABLE PRIPADA
ADD CONSTRAINT PRIPADA_pk primary key (url, pib)
GO
ALTER TABLE PRIPADA
ADD CONSTRAINT PRIPADA1_fk foreign key (url) REFERENCES "ONLINE PRODAVNICA" (url)
GO
ALTER TABLE PRIPADA
ADD CONSTRAINT PRIPADA2_fk foreign key (pib) REFERENCES FIRMA (pib)
GO
ALTER TABLE PRISTUPA
ADD CONSTRAINT PRISTUPA_pk primary key (url, jmbg)
GO
ALTER TABLE PRISTUPA
ADD CONSTRAINT PRISTUPA1_fk foreign key (url) REFERENCES "ONLINE PRODAVNICA" (url)
GO
ALTER TABLE PRISTUPA
ADD CONSTRAINT PRISTUPA2_fk foreign key (jmbg) REFERENCES KORISNIK (jmbg)
GO
ALTER TABLE PRODAJE
ADD CONSTRAINT PRODAJE_pk primary key (url, id_porudžbine)
GO
ALTER TABLE PRODAJE
ADD CONSTRAINT PRODAJE1_fk foreign key (url) REFERENCES "ONLINE PRODAVNICA" (url)
GO
ALTER TABLE PRODAJE
ADD CONSTRAINT PRODAJE2_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE PORUČUJE
ADD CONSTRAINT PORUČUJE_pk primary key (id_porudžbine, url, jmbg)
GO
ALTER TABLE PORUČUJE
ADD CONSTRAINT PORUČUJE1_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE PORUČUJE
ADD CONSTRAINT fk_PORUČUJE foreign key (url, jmbg) REFERENCES PRISTUPA (url, jmbg)
GO
ALTER TABLE "BOX PAKET"
ADD CONSTRAINT BOX_PAKET_fk foreign key (id_recepta) REFERENCES RECEPT (id_recepta)
GO
ALTER TABLE ČINE
ADD CONSTRAINT ČINE_pk primary key (id_porudžbine, šifra_namirnice)
GO
ALTER TABLE ČINE
ADD CONSTRAINT ČINE1_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE ČINE
ADD CONSTRAINT ČINE2_fk foreign key (šifra_namirnice) REFERENCES NAMIRNICE (šifra_namirnice)
GO
ALTER TABLE "INTERNACIONALNA JELA"
ADD CONSTRAINT INTERNACIONALNA_JELA_pk primary key (id_porudžbine)
GO
ALTER TABLE "INTERNACIONALNA JELA"
ADD CONSTRAINT INTERNACIONALNA_JELA_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE "TRADICIONALNA JELA"
ADD CONSTRAINT TRADICIONALNA_JELA_pk primary key (id_porudžbine)
GO
ALTER TABLE "TRADICIONALNA JELA"
ADD CONSTRAINT TRADICIONALNA_JELA_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE "VEGANSKA JELA"
ADD CONSTRAINT VEGANSKA_JELA_pk primary key (id_porudžbine)
GO
ALTER TABLE "VEGANSKA JELA"
ADD CONSTRAINT VEGANSKA_JELA_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE "JELA ZA DIJABETIČARE"
ADD CONSTRAINT JELA_ZA_DIJABETIČARE_pk primary key (id_porudžbine)
GO
ALTER TABLE "JELA ZA DIJABETIČARE"
ADD CONSTRAINT JELA_ZA_DIJABETIČARE_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE PREDAJE
ADD CONSTRAINT PREDAJE_pk primary key (url, id_porudžbine, pib)
GO
ALTER TABLE PREDAJE
ADD CONSTRAINT fk_PRODAJE foreign key (url, id_porudžbine) REFERENCES PRODAJE (url, id_porudžbine)
GO
ALTER TABLE PREDAJE
ADD CONSTRAINT PREDAJE1_fk foreign key (pib) REFERENCES "KURIRSKA SLUŽBA" (pib)
GO
ALTER TABLE ISPORUČUJE
ADD CONSTRAINT ISPORUČUJE_pk primary key (pib, jmbg)
GO
ALTER TABLE ISPORUČUJE
ADD CONSTRAINT ISPORUČUJE1_fk foreign key (pib) REFERENCES "KURIRSKA SLUŽBA" (pib)
GO
ALTER TABLE ISPORUČUJE
ADD CONSTRAINT ISPORUČUJE2_fk foreign key (jmbg) REFERENCES KORISNIK (jmbg)
GO
ALTER TABLE KORISNIK
ADD CONSTRAINT KORISNIK_fk foreign key (ptt) REFERENCES MESTO (ptt)
GO
ALTER TABLE FIRMA
ADD CONSTRAINT FIRMA_fk foreign key (ptt) REFERENCES MESTO (ptt)
GO
/* Primer upotrebe ALTER i DROP naredbe: */
CREATE TABLE SADRŽI
(
id_porudžbine int NOT NULL,
šifra_namirnice int NOT NULL
)
GO
ALTER TABLE SADRŽI
ADD CONSTRAINT SADRŽI_pk primary key (id_porudžbine, šifra_namirnice)
GO
ALTER TABLE SADRŽI
ADD CONSTRAINT SADRŽI1_fk foreign key (id_porudžbine) REFERENCES "BOX PAKET" (id_porudžbine)
GO
ALTER TABLE SADRŽI
ADD CONSTRAINT SADRŽI2_fk foreign key (šifra_namirnice) REFERENCES NAMIRNICE (šifra_namirnice)
GO
DROP TABLE SADRŽI
GO
/*SQL Upiti za ažuriranje baze podataka Online prodaja namirnica*/
INSERT INTO MESTO (ptt, naziv_mesta)
VALUES (11000, 'Beograd') /* MESTO - FIRMA */
GO
INSERT INTO MESTO (ptt, naziv_mesta)
VALUES (21000, 'Novi Sad') /* MESTO - KORISNIK*/
GO
INSERT INTO FIRMA
VALUES (814777373, 'Blue Apron', 'Svetosavska 34', 11000)
GO
INSERT INTO "ONLINE PRODAVNICA" (url, web_stranica, inbox, naziv, domen)
VALUES ('https://www.blueapron.com/', 'Blue Apron: Servis dostave hrane', 'press@blueapron.com', 'Blue Apron', 'www.blueapron.com')
GO
INSERT INTO KORISNIK (jmbg, ime, prezime, ulica_i_broj, ptt)
VALUES (1306998000000, 'Petar', 'Petrović', 'Cara Dušana 43', 21000)
GO
INSERT INTO PRIPADA
VALUES ('https://www.blueapron.com/', 814777373)
GO
INSERT INTO PRISTUPA
VALUES ('https://www.blueapron.com/', 1306998000000)
GO
INSERT INTO RECEPT (id_recepta, naziv_sastojaka, količina, uputstvo)
VALUES (000001, 'Tofu', '397g', 'Kada se tofu iscedi, iseći ga na kockice.') /* "VEGANSKA JELA" */
GO
INSERT INTO RECEPT (id_recepta, naziv_sastojaka, količina, uputstvo)
VALUES (000002, 'Pirinač', '190g', NULL) /* "INTERNACIONALNA JELA" */
GO
INSERT INTO RECEPT (id_recepta, naziv_sastojaka, količina, uputstvo)
VALUES (000003, 'Kupus', '500g', 'U list kupusa uviti nadev od mesa.') /* "TRADICIONALNA JELA" */
GO
INSERT INTO RECEPT (id_recepta, naziv_sastojaka, količina, uputstvo)
VALUES (000004, 'Stevia', '5g', NULL) /* "JELA ZA DIJABETIČARE" */
GO
INSERT INTO "BOX PAKET" (id_porudžbine, id_recepta, naziv, cena, pdv)
VALUES (123456, 000001, 'Party pack', 3000, 3600.00) /* VALUTA = RSD */ /* "VEGANSKA JELA" */
GO
INSERT INTO "BOX PAKET" (id_porudžbine, id_recepta, naziv, cena, pdv)
VALUES (123457, 000002, 'Party pack2', 2000, 2400.00) /* VALUTA = RSD */ /* "INTERNACIONALNA JELA" */
GO
INSERT INTO "BOX PAKET" (id_porudžbine, id_recepta, naziv, cena, pdv)
VALUES (123458, 000003, 'Party pack3', 4000, 4800.00) /* VALUTA = RSD */ /* "TRADICIONALNA JELA" */
GO
INSERT INTO "BOX PAKET" (id_porudžbine, id_recepta, naziv, cena, pdv)
VALUES (123459, 000004, 'Party pack4', 1000, 1200.00) /* VALUTA = RSD */ /* "JELA ZA DIJABETIČARE" */
GO
INSERT INTO PRODAJE
VALUES ('https://www.blueapron.com/', 123456)
GO
INSERT INTO NAMIRNICE (šifra_namirnice, naziv_namirnice, gramaža) /* "VEGANSKA JELA" */
VALUES (111111, 'Tofu', '397g')
GO
INSERT INTO NAMIRNICE (šifra_namirnice, naziv_namirnice, gramaža) /* "INTERNACIONALNA JELA" */
VALUES (222222, 'Pirinač', '190g')
GO
INSERT INTO NAMIRNICE (šifra_namirnice, naziv_namirnice, gramaža) /* "TRADICIONALNA JELA" */
VALUES (333333, 'Kupus', '500g')
GO
INSERT INTO NAMIRNICE (šifra_namirnice, naziv_namirnice, gramaža) /* "JELA ZA DIJABETIČARE" */
VALUES (444444, 'Stevia', '5g')
GO
INSERT INTO "INTERNACIONALNA JELA"
VALUES (123457, 'Japan')
GO
INSERT INTO "TRADICIONALNA JELA"
VALUES (123458, 'Banat')
GO
INSERT INTO "VEGANSKA JELA" (id_porudžbine, naziv_veganskog_jela)
VALUES (123456, 'Tofu omlet')
GO
INSERT INTO "JELA ZA DIJABETIČARE"
VALUES (123459, 'Stevia')
GO
INSERT INTO PORUČUJE
VALUES (123456, 1306998000000, 'https://www.blueapron.com/', '2020-02-10')
GO
INSERT INTO ČINE
VALUES (123456, 111111) /* "VEGANSKA JELA" */
GO
INSERT INTO ČINE
VALUES (123457, 222222) /* "INTERNACIONALNA JELA" */
GO
INSERT INTO ČINE
VALUES (123458, 333333) /* "TRADICIONALNA JELA" */
GO
INSERT INTO ČINE
VALUES (123459, 444444) /* "JELA ZA DIJABETIČARE" */
GO
INSERT INTO "KURIRSKA SLUŽBA" (pib, naziv_firme)
VALUES (621721435, 'FedEx')
GO
INSERT INTO PREDAJE
VALUES (621721435, 'https://www.blueapron.com/', 123456, '2020-02-11')
GO
INSERT INTO ISPORUČUJE
VALUES (621721435, 1306998000000)
GO
/* Primer upotrebe UPDATE i DELETE naredbe: */
INSERT INTO "KURIRSKA SLUŽBA" (pib, naziv_firme)
VALUES (111111111, 'Food Express')
GO
UPDATE "KURIRSKA SLUŽBA"
SET pib = 222222222
WHERE pib = 111111111
GO
DELETE "KURIRSKA SLUŽBA"
WHERE pib = 222222222