CREATE TABLE draft (
    iddraft     INTEGER NOT NULL,
    gododrdraft VARCHAR2(4 CHAR),
    lokodrdraft VARCHAR2(64 CHAR)
);

ALTER TABLE draft ADD CONSTRAINT draft_pk PRIMARY KEY ( iddraft );

CREATE TABLE formira (
    idtrejd     INTEGER NOT NULL,
    matbrzapmen INTEGER NOT NULL
);

ALTER TABLE formira ADD CONSTRAINT formira_pk PRIMARY KEY ( idtrejd,
                                                            matbrzapmen );

CREATE TABLE igrac (
    matbrzap   INTEGER NOT NULL,
    imeigr     VARCHAR2(32 CHAR),
    przigr     VARCHAR2(32 CHAR),
    datrodjigr DATE,
    visigr     VARCHAR2(3 CHAR),
    tezigr     VARCHAR2(3 CHAR),
    pozigr     VARCHAR2(32 CHAR)
);

ALTER TABLE igrac
    ADD CHECK ( pozigr IN ( 'Bek suter (SG)', 'Centar (C)', 'Krilni centar (PF)', 'Krilo (SF)', 'Plejmejker (PG)' ) );

ALTER TABLE igrac ADD CONSTRAINT igrac_pk PRIMARY KEY ( matbrzap );

CREATE TABLE menadzer (
    matbrzap INTEGER NOT NULL
);

ALTER TABLE menadzer ADD CONSTRAINT menadzer_pk PRIMARY KEY ( matbrzap );

CREATE TABLE nadgleda (
    matbrzap INTEGER NOT NULL,
    idtrng   INTEGER NOT NULL,
    idnov    INTEGER NOT NULL,
    iddraft  INTEGER NOT NULL
);

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_pk PRIMARY KEY ( matbrzap,
                                             idtrng,
                                             idnov,
                                             iddraft );

CREATE TABLE novajlija (
    idnov      INTEGER NOT NULL,
    imenov     VARCHAR2(32 CHAR),
    prznov     VARCHAR2(32 CHAR),
    datrodjnov DATE,
    visnov     VARCHAR2(3 CHAR),
    teznov     VARCHAR2(3 CHAR),
    poznov     VARCHAR2(32 CHAR),
    ocnov      INTEGER,
    mesrodjnov VARCHAR2(32 CHAR),
    iddraft    INTEGER NOT NULL
);

ALTER TABLE novajlija ADD CONSTRAINT novajlija_pk PRIMARY KEY ( idnov,
                                                                iddraft );

CREATE TABLE odrzava_se (
    idtrng  INTEGER NOT NULL,
    idteren INTEGER NOT NULL
);

ALTER TABLE odrzava_se ADD CONSTRAINT odrzava_se_pk PRIMARY KEY ( idtrng,
                                                                  idteren );

CREATE TABLE organizuje (
    matbrzap INTEGER NOT NULL,
    idtrng   INTEGER NOT NULL
);

ALTER TABLE organizuje ADD CONSTRAINT organizuje_pk PRIMARY KEY ( matbrzap,
                                                                  idtrng );

CREATE TABLE pik (
    idpik    INTEGER NOT NULL,
    redbrpik VARCHAR2(2 CHAR),
    brrunpik VARCHAR2(1 CHAR),
    godpik   VARCHAR2(4 CHAR),
    idtim    INTEGER NOT NULL,
    matbrzap INTEGER NOT NULL,
    idnov    INTEGER NOT NULL,
    iddraft  INTEGER NOT NULL
);

CREATE UNIQUE INDEX pik__idx ON
    pik (
        idnov
    ASC,
        iddraft
    ASC );

ALTER TABLE pik ADD CONSTRAINT pik_pk PRIMARY KEY ( idpik );

CREATE TABLE sadrzi (
    matbrzapigr INTEGER NOT NULL,
    idtrejd     INTEGER NOT NULL
);

ALTER TABLE sadrzi ADD CONSTRAINT sadrzi_pk PRIMARY KEY ( matbrzapigr,
                                                          idtrejd );

CREATE TABLE skaut (
    matbrzap    INTEGER NOT NULL,
    matbrnadzap INTEGER NOT NULL
);

ALTER TABLE skaut ADD CONSTRAINT skaut_pk PRIMARY KEY ( matbrzap );

CREATE TABLE teren (
    idteren     INTEGER NOT NULL,
    gradteren   VARCHAR2(32 CHAR),
    podteren    VARCHAR2(32 CHAR),
    ulicateren  VARCHAR2(32 CHAR),
    bradrteren  VARCHAR2(6 CHAR),
    drzavateren VARCHAR2(32 CHAR)
);

ALTER TABLE teren ADD CONSTRAINT teren_pk PRIMARY KEY ( idteren );

CREATE TABLE tim (
    idtim     INTEGER NOT NULL,
    naztim    VARCHAR2(64 CHAR),
    godosntim VARCHAR2(4 CHAR),
    loktim    VARCHAR2(64 CHAR)
);

ALTER TABLE tim ADD CONSTRAINT tim_pk PRIMARY KEY ( idtim );

CREATE TABLE tip_treninga (
    idtiptrng   INTEGER NOT NULL,
    naztiptrng  VARCHAR2(32 CHAR),
    ciljtiptrng VARCHAR2(32 CHAR)
);

ALTER TABLE tip_treninga ADD CONSTRAINT tip_treninga_pk PRIMARY KEY ( idtiptrng );

CREATE TABLE trejd (
    idtrejd   INTEGER NOT NULL,
    dattrejd  DATE,
    tiptrejd  VARCHAR2(32 CHAR),
    odobtrejd VARCHAR2(32 CHAR)
);

ALTER TABLE trejd
    ADD CHECK ( tiptrejd IN ( 'Mesano', 'Samo igraci', 'Samo pikovi' ) );

ALTER TABLE trejd ADD CONSTRAINT trejd_pk PRIMARY KEY ( idtrejd );

CREATE TABLE trener (
    matbrzap     INTEGER NOT NULL,
    godisktrener INTEGER,
    spectrener   VARCHAR2(32 CHAR),
    matbrnadzap  INTEGER NOT NULL
);

ALTER TABLE trener ADD CONSTRAINT trener_pk PRIMARY KEY ( matbrzap );

CREATE TABLE trening (
    idtrng    INTEGER NOT NULL,
    trajtrng  INTEGER,
    dattrng   DATE,
    idtiptrng INTEGER NOT NULL
);

ALTER TABLE trening ADD CONSTRAINT trening_pk PRIMARY KEY ( idtrng );

CREATE TABLE ucestvuje (
    idtrng  INTEGER NOT NULL,
    idnov   INTEGER NOT NULL,
    iddraft INTEGER NOT NULL
);

ALTER TABLE ucestvuje
    ADD CONSTRAINT ucestvuje_pk PRIMARY KEY ( idtrng,
                                              idnov,
                                              iddraft );

CREATE TABLE ugovor (
    idugo     INTEGER NOT NULL,
    datpotugo DATE,
    datvazugo DATE,
    tipugo    VARCHAR2(32 CHAR),
    vredugo   VARCHAR2(12),
    idtim     INTEGER NOT NULL,
    idnov     INTEGER NOT NULL,
    iddraft   INTEGER NOT NULL
);

ALTER TABLE ugovor
    ADD CHECK ( tipugo IN ( 'One-Way', 'Two-Way' ) );

CREATE UNIQUE INDEX ugovor__idx ON
    ugovor (
        idnov
    ASC,
        iddraft
    ASC );

ALTER TABLE ugovor ADD CONSTRAINT ugovor_pk PRIMARY KEY ( idugo );

CREATE TABLE ukljucuje (
    idtrejd INTEGER NOT NULL,
    idpik   INTEGER NOT NULL
);

ALTER TABLE ukljucuje ADD CONSTRAINT ukljucuje_pk PRIMARY KEY ( idtrejd,
                                                                idpik );

CREATE TABLE zaposleni (
    matbrzap   INTEGER NOT NULL,
    imezap     VARCHAR2(24 CHAR),
    przzap     VARCHAR2(32 CHAR),
    datrodjzap DATE,
    ulozap     VARCHAR2(32 CHAR),
    idtim      INTEGER NOT NULL
);

ALTER TABLE zaposleni
    ADD CHECK ( ulozap IN ( 'Igrac', 'Menadzer', 'Skaut', 'Trener' ) );

ALTER TABLE zaposleni ADD CONSTRAINT zaposleni_pk PRIMARY KEY ( matbrzap );

ALTER TABLE formira
    ADD CONSTRAINT formira_menadzer_fk FOREIGN KEY ( matbrzapmen )
        REFERENCES menadzer ( matbrzap );

ALTER TABLE formira
    ADD CONSTRAINT formira_trejd_fk FOREIGN KEY ( idtrejd )
        REFERENCES trejd ( idtrejd );

ALTER TABLE igrac
    ADD CONSTRAINT igrac_zaposleni_fk FOREIGN KEY ( matbrzap )
        REFERENCES zaposleni ( matbrzap );

ALTER TABLE menadzer
    ADD CONSTRAINT menadzer_zaposleni_fk FOREIGN KEY ( matbrzap )
        REFERENCES zaposleni ( matbrzap );

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_skaut_fk FOREIGN KEY ( matbrzap )
        REFERENCES skaut ( matbrzap );

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_ucestvuje_fk FOREIGN KEY ( idtrng,
                                                       idnov,
                                                       iddraft )
        REFERENCES ucestvuje ( idtrng,
                               idnov,
                               iddraft );

ALTER TABLE novajlija
    ADD CONSTRAINT novajlija_draft_fk FOREIGN KEY ( iddraft )
        REFERENCES draft ( iddraft );

ALTER TABLE odrzava_se
    ADD CONSTRAINT odrzava_se_teren_fk FOREIGN KEY ( idteren )
        REFERENCES teren ( idteren );

ALTER TABLE odrzava_se
    ADD CONSTRAINT odrzava_se_trening_fk FOREIGN KEY ( idtrng )
        REFERENCES trening ( idtrng );

ALTER TABLE organizuje
    ADD CONSTRAINT organizuje_trener_fk FOREIGN KEY ( matbrzap )
        REFERENCES trener ( matbrzap );

ALTER TABLE organizuje
    ADD CONSTRAINT organizuje_trening_fk FOREIGN KEY ( idtrng )
        REFERENCES trening ( idtrng );

ALTER TABLE pik
    ADD CONSTRAINT pik_menadzer_fk FOREIGN KEY ( matbrzap )
        REFERENCES menadzer ( matbrzap );

ALTER TABLE pik
    ADD CONSTRAINT pik_novajlija_fk FOREIGN KEY ( idnov,
                                                  iddraft )
        REFERENCES novajlija ( idnov,
                               iddraft );

ALTER TABLE pik
    ADD CONSTRAINT pik_tim_fk FOREIGN KEY ( idtim )
        REFERENCES tim ( idtim );

ALTER TABLE sadrzi
    ADD CONSTRAINT sadrzi_igrac_fk FOREIGN KEY ( matbrzapigr )
        REFERENCES igrac ( matbrzap );

ALTER TABLE sadrzi
    ADD CONSTRAINT sadrzi_trejd_fk FOREIGN KEY ( idtrejd )
        REFERENCES trejd ( idtrejd );

ALTER TABLE skaut
    ADD CONSTRAINT skaut_skaut_fk FOREIGN KEY ( matbrnadzap )
        REFERENCES skaut ( matbrzap );

ALTER TABLE skaut
    ADD CONSTRAINT skaut_zaposleni_fk FOREIGN KEY ( matbrzap )
        REFERENCES zaposleni ( matbrzap );

ALTER TABLE trener
    ADD CONSTRAINT trener_trener_fk FOREIGN KEY ( matbrnadzap )
        REFERENCES trener ( matbrzap );

ALTER TABLE trener
    ADD CONSTRAINT trener_zaposleni_fk FOREIGN KEY ( matbrzap )
        REFERENCES zaposleni ( matbrzap );

ALTER TABLE trening
    ADD CONSTRAINT trening_tip_treninga_fk FOREIGN KEY ( idtiptrng )
        REFERENCES tip_treninga ( idtiptrng );

ALTER TABLE ucestvuje
    ADD CONSTRAINT ucestvuje_novajlija_fk FOREIGN KEY ( idnov,
                                                        iddraft )
        REFERENCES novajlija ( idnov,
                               iddraft );

ALTER TABLE ucestvuje
    ADD CONSTRAINT ucestvuje_trening_fk FOREIGN KEY ( idtrng )
        REFERENCES trening ( idtrng );

ALTER TABLE ugovor
    ADD CONSTRAINT ugovor_novajlija_fk FOREIGN KEY ( idnov,
                                                     iddraft )
        REFERENCES novajlija ( idnov,
                               iddraft );

ALTER TABLE ugovor
    ADD CONSTRAINT ugovor_tim_fk FOREIGN KEY ( idtim )
        REFERENCES tim ( idtim );

ALTER TABLE ukljucuje
    ADD CONSTRAINT ukljucuje_pik_fk FOREIGN KEY ( idpik )
        REFERENCES pik ( idpik );

ALTER TABLE ukljucuje
    ADD CONSTRAINT ukljucuje_trejd_fk FOREIGN KEY ( idtrejd )
        REFERENCES trejd ( idtrejd );

ALTER TABLE zaposleni
    ADD CONSTRAINT zaposleni_tim_fk FOREIGN KEY ( idtim )
        REFERENCES tim ( idtim );
        