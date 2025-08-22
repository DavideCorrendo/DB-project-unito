--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Ubuntu 17.5-0ubuntu0.25.04.1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-0ubuntu0.25.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: abilitate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abilitate (
    id_itinerario integer NOT NULL,
    cod_guida integer NOT NULL
);


ALTER TABLE public.abilitate OWNER TO postgres;

--
-- Name: adottano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adottano (
    nome_trattamenti character varying(50) NOT NULL,
    id_struttura integer NOT NULL
);


ALTER TABLE public.adottano OWNER TO postgres;

--
-- Name: alloggiano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alloggiano (
    id_struttura integer NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.alloggiano OWNER TO postgres;

--
-- Name: centri_visita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.centri_visita (
    cod integer NOT NULL,
    orario_apertura time without time zone NOT NULL,
    luogo character varying(100) NOT NULL,
    orario_chiusura time without time zone NOT NULL,
    nome_centro character varying(100) NOT NULL,
    email character varying(100),
    num_telefono character varying(20),
    percorsi text,
    visite text,
    id_parco integer NOT NULL,
    CONSTRAINT centri_visita_check CHECK ((orario_chiusura > orario_apertura))
);


ALTER TABLE public.centri_visita OWNER TO postgres;

--
-- Name: certificazioni_possedute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificazioni_possedute (
    nome_certificazione character varying(50) NOT NULL
);


ALTER TABLE public.certificazioni_possedute OWNER TO postgres;

--
-- Name: contiene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contiene (
    id_segnaletica integer NOT NULL,
    id_itinerario integer NOT NULL
);


ALTER TABLE public.contiene OWNER TO postgres;

--
-- Name: dispone_di; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dispone_di (
    nome_certificazione character varying(50) NOT NULL,
    id_parco integer NOT NULL
);


ALTER TABLE public.dispone_di OWNER TO postgres;

--
-- Name: effettuano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.effettuano (
    username character varying(50) NOT NULL,
    orario time without time zone NOT NULL,
    anno integer NOT NULL,
    data_prenotazione date
);


ALTER TABLE public.effettuano OWNER TO postgres;

--
-- Name: erogano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.erogano (
    cod_centro integer NOT NULL,
    nome_servizio character varying(50) NOT NULL
);


ALTER TABLE public.erogano OWNER TO postgres;

--
-- Name: guide_autorizzate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guide_autorizzate (
    cod integer NOT NULL,
    cognome character varying(50) NOT NULL,
    nome character varying(50) NOT NULL,
    media_valutazione numeric(2,1),
    CONSTRAINT guide_autorizzate_media_valutazione_check CHECK (((media_valutazione >= (1)::numeric) AND (media_valutazione <= (5)::numeric)))
);


ALTER TABLE public.guide_autorizzate OWNER TO postgres;

--
-- Name: impegni_ecologici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.impegni_ecologici (
    nome_impegno character varying(50) NOT NULL
);


ALTER TABLE public.impegni_ecologici OWNER TO postgres;

--
-- Name: informano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.informano (
    cod_notizie integer NOT NULL,
    id_parco integer NOT NULL
);


ALTER TABLE public.informano OWNER TO postgres;

--
-- Name: invia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invia (
    username character varying(50) NOT NULL,
    id_richiesta integer NOT NULL
);


ALTER TABLE public.invia OWNER TO postgres;

--
-- Name: itinerari; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itinerari (
    id integer NOT NULL,
    media_valutazione numeric(2,1),
    numero_guide_abilitate integer NOT NULL,
    tempo_stimato integer NOT NULL,
    modalita_percorrenza character varying(20) NOT NULL,
    punto_partenza character varying(100) NOT NULL,
    livello_difficolta character varying(20) NOT NULL,
    id_parco integer NOT NULL,
    CONSTRAINT itinerari_media_valutazione_check CHECK (((media_valutazione >= (1)::numeric) AND (media_valutazione <= (5)::numeric))),
    CONSTRAINT itinerari_numero_guide_abilitate_check CHECK ((numero_guide_abilitate >= 1)),
    CONSTRAINT itinerari_tempo_stimato_check CHECK ((tempo_stimato > 0))
);


ALTER TABLE public.itinerari OWNER TO postgres;

--
-- Name: licenze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licenze (
    nome_licenza character varying(50) NOT NULL
);


ALTER TABLE public.licenze OWNER TO postgres;

--
-- Name: notizie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notizie (
    cod integer NOT NULL,
    data date NOT NULL,
    foto text,
    testo text NOT NULL,
    id_parco integer NOT NULL,
    CONSTRAINT notizie_data_check CHECK ((data <= CURRENT_DATE))
);


ALTER TABLE public.notizie OWNER TO postgres;

--
-- Name: offre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offre (
    id_struttura integer NOT NULL,
    nome_servizio character varying(50) NOT NULL
);


ALTER TABLE public.offre OWNER TO postgres;

--
-- Name: organizzano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizzano (
    cod_guida integer NOT NULL,
    orario time without time zone NOT NULL,
    anno integer NOT NULL
);


ALTER TABLE public.organizzano OWNER TO postgres;

--
-- Name: parchi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parchi (
    id integer NOT NULL,
    tipologia character varying(20) NOT NULL,
    ente_gestore character varying(50) NOT NULL,
    regione character varying(25) NOT NULL,
    superficie_terrestre numeric(10,2) NOT NULL,
    nome_parco character varying(100) NOT NULL,
    superficie_marina numeric(10,2),
    provvedimento_istitutivo text,
    km_costa numeric(8,2),
    CONSTRAINT chk_superficie_costa CHECK ((((km_costa = (0)::numeric) AND (superficie_marina = (0)::numeric)) OR ((km_costa > (0)::numeric) AND (superficie_marina > (0)::numeric)))),
    CONSTRAINT parchi_ente_gestore_check CHECK (((ente_gestore)::text = ANY ((ARRAY['Ministero dell''Ambiente'::character varying, 'regione'::character varying, 'provincia'::character varying, 'comune'::character varying, 'associazione'::character varying, 'ente di gestione di aree protette'::character varying, 'privato'::character varying])::text[]))),
    CONSTRAINT parchi_km_costa_check CHECK ((km_costa >= (0)::numeric)),
    CONSTRAINT parchi_regione_check CHECK (((regione)::text = ANY ((ARRAY['Piemonte'::character varying, 'Valle d''Aosta'::character varying, 'Lombardia'::character varying, 'Trentino-Alto Adige'::character varying, 'Veneto'::character varying, 'Friuli-Venezia Giulia'::character varying, 'Liguria'::character varying, 'Emilia-Romagna'::character varying, 'Toscana'::character varying, 'Umbria'::character varying, 'Marche'::character varying, 'Lazio'::character varying, 'Abruzzo'::character varying, 'Molise'::character varying, 'Campania'::character varying, 'Puglia'::character varying, 'Basilicata'::character varying, 'Calabria'::character varying, 'Sicilia'::character varying, 'Sardegna'::character varying])::text[]))),
    CONSTRAINT parchi_superficie_marina_check CHECK ((superficie_marina >= (0)::numeric)),
    CONSTRAINT parchi_superficie_terrestre_check CHECK ((superficie_terrestre > (0)::numeric)),
    CONSTRAINT parchi_tipologia_check CHECK (((tipologia)::text = ANY ((ARRAY['parco nazionale'::character varying, 'riserva naturale'::character varying])::text[])))
);


ALTER TABLE public.parchi OWNER TO postgres;

--
-- Name: possiedono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.possiedono (
    cod_guida integer NOT NULL,
    nome_licenza character varying(50) NOT NULL
);


ALTER TABLE public.possiedono OWNER TO postgres;

--
-- Name: presenze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presenze (
    cod integer NOT NULL,
    tipologia_utente character varying(20) NOT NULL,
    orario_entrata time without time zone NOT NULL,
    orario_uscita time without time zone NOT NULL,
    data date NOT NULL,
    username character varying(50) NOT NULL,
    id_parco integer NOT NULL,
    CONSTRAINT presenze_check CHECK ((orario_uscita >= orario_entrata))
);


ALTER TABLE public.presenze OWNER TO postgres;

--
-- Name: richieste_prenotazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.richieste_prenotazione (
    id integer NOT NULL,
    data_inizio_soggiorno date NOT NULL,
    data_fine_soggiorno date NOT NULL,
    num_ospiti integer NOT NULL,
    stato_accettazione character varying(20) NOT NULL,
    username character varying(50) NOT NULL,
    id_struttura integer NOT NULL,
    CONSTRAINT chk_date_soggiorno CHECK ((data_fine_soggiorno > data_inizio_soggiorno)),
    CONSTRAINT richieste_prenotazione_data_inizio_soggiorno_check CHECK ((data_inizio_soggiorno >= CURRENT_DATE)),
    CONSTRAINT richieste_prenotazione_num_ospiti_check CHECK ((num_ospiti > 0))
);


ALTER TABLE public.richieste_prenotazione OWNER TO postgres;

--
-- Name: segnaletica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segnaletica (
    id integer NOT NULL,
    tipo_segnaletica character varying(50) NOT NULL,
    id_itinerario integer NOT NULL
);


ALTER TABLE public.segnaletica OWNER TO postgres;

--
-- Name: segue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segue (
    id_struttura integer NOT NULL,
    nome_impegno character varying(50) NOT NULL
);


ALTER TABLE public.segue OWNER TO postgres;

--
-- Name: servizi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servizi (
    nome_servizio character varying(50) NOT NULL
);


ALTER TABLE public.servizi OWNER TO postgres;

--
-- Name: si_possono_consultare; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.si_possono_consultare (
    id_parco integer NOT NULL,
    id_itinerario integer NOT NULL
);


ALTER TABLE public.si_possono_consultare OWNER TO postgres;

--
-- Name: strutture_ricettive; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strutture_ricettive (
    id integer NOT NULL,
    nome_struttura character varying(100) NOT NULL,
    indirizzo character varying(200) NOT NULL,
    adesione_cets boolean,
    disponibilita_parcheggi boolean,
    scuola boolean,
    gruppi boolean,
    email character varying(100),
    num_telefono character varying(20),
    id_parco integer NOT NULL
);


ALTER TABLE public.strutture_ricettive OWNER TO postgres;

--
-- Name: tour_programmati; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_programmati (
    orario time without time zone NOT NULL,
    anno integer NOT NULL,
    num_massimo_partecipanti integer NOT NULL,
    stato character varying(20) NOT NULL,
    cod_guida integer NOT NULL,
    id_itinerario integer NOT NULL,
    CONSTRAINT tour_programmati_num_massimo_partecipanti_check CHECK ((num_massimo_partecipanti > 0))
);


ALTER TABLE public.tour_programmati OWNER TO postgres;

--
-- Name: trattamenti_disponibili; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trattamenti_disponibili (
    nome_trattamenti character varying(50) NOT NULL
);


ALTER TABLE public.trattamenti_disponibili OWNER TO postgres;

--
-- Name: valutazioni; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.valutazioni (
    id integer NOT NULL,
    commento text,
    punteggio integer NOT NULL,
    username character varying(50) NOT NULL,
    cod_guida integer NOT NULL,
    id_itinerario integer NOT NULL,
    CONSTRAINT valutazioni_punteggio_check CHECK ((punteggio = ANY (ARRAY[1, 2, 3, 4, 5])))
);


ALTER TABLE public.valutazioni OWNER TO postgres;

--
-- Name: visitatori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitatori (
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    tipologia character varying(20) NOT NULL
);


ALTER TABLE public.visitatori OWNER TO postgres;

--
-- Name: abilitate abilitate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abilitate
    ADD CONSTRAINT abilitate_pkey PRIMARY KEY (id_itinerario, cod_guida);


--
-- Name: adottano adottano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adottano
    ADD CONSTRAINT adottano_pkey PRIMARY KEY (nome_trattamenti, id_struttura);


--
-- Name: alloggiano alloggiano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alloggiano
    ADD CONSTRAINT alloggiano_pkey PRIMARY KEY (id_struttura, username);


--
-- Name: centri_visita centri_visita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centri_visita
    ADD CONSTRAINT centri_visita_pkey PRIMARY KEY (cod);


--
-- Name: certificazioni_possedute certificazioni_possedute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificazioni_possedute
    ADD CONSTRAINT certificazioni_possedute_pkey PRIMARY KEY (nome_certificazione);


--
-- Name: contiene contiene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_pkey PRIMARY KEY (id_segnaletica, id_itinerario);


--
-- Name: dispone_di dispone_di_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispone_di
    ADD CONSTRAINT dispone_di_pkey PRIMARY KEY (nome_certificazione, id_parco);


--
-- Name: effettuano effettuano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.effettuano
    ADD CONSTRAINT effettuano_pkey PRIMARY KEY (username, orario, anno);


--
-- Name: erogano erogano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.erogano
    ADD CONSTRAINT erogano_pkey PRIMARY KEY (cod_centro, nome_servizio);


--
-- Name: guide_autorizzate guide_autorizzate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guide_autorizzate
    ADD CONSTRAINT guide_autorizzate_pkey PRIMARY KEY (cod);


--
-- Name: impegni_ecologici impegni_ecologici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.impegni_ecologici
    ADD CONSTRAINT impegni_ecologici_pkey PRIMARY KEY (nome_impegno);


--
-- Name: informano informano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informano
    ADD CONSTRAINT informano_pkey PRIMARY KEY (cod_notizie, id_parco);


--
-- Name: invia invia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invia
    ADD CONSTRAINT invia_pkey PRIMARY KEY (username, id_richiesta);


--
-- Name: itinerari itinerari_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itinerari
    ADD CONSTRAINT itinerari_pkey PRIMARY KEY (id);


--
-- Name: licenze licenze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenze
    ADD CONSTRAINT licenze_pkey PRIMARY KEY (nome_licenza);


--
-- Name: notizie notizie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notizie
    ADD CONSTRAINT notizie_pkey PRIMARY KEY (cod);


--
-- Name: offre offre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offre
    ADD CONSTRAINT offre_pkey PRIMARY KEY (id_struttura, nome_servizio);


--
-- Name: organizzano organizzano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzano
    ADD CONSTRAINT organizzano_pkey PRIMARY KEY (cod_guida, orario, anno);


--
-- Name: parchi parchi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parchi
    ADD CONSTRAINT parchi_pkey PRIMARY KEY (id);


--
-- Name: possiedono possiedono_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.possiedono
    ADD CONSTRAINT possiedono_pkey PRIMARY KEY (cod_guida, nome_licenza);


--
-- Name: presenze presenze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presenze
    ADD CONSTRAINT presenze_pkey PRIMARY KEY (cod);


--
-- Name: richieste_prenotazione richieste_prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.richieste_prenotazione
    ADD CONSTRAINT richieste_prenotazione_pkey PRIMARY KEY (id);


--
-- Name: segnaletica segnaletica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnaletica
    ADD CONSTRAINT segnaletica_pkey PRIMARY KEY (id);


--
-- Name: segue segue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segue
    ADD CONSTRAINT segue_pkey PRIMARY KEY (id_struttura, nome_impegno);


--
-- Name: servizi servizi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servizi
    ADD CONSTRAINT servizi_pkey PRIMARY KEY (nome_servizio);


--
-- Name: si_possono_consultare si_possono_consultare_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.si_possono_consultare
    ADD CONSTRAINT si_possono_consultare_pkey PRIMARY KEY (id_parco, id_itinerario);


--
-- Name: strutture_ricettive strutture_ricettive_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strutture_ricettive
    ADD CONSTRAINT strutture_ricettive_pkey PRIMARY KEY (id);


--
-- Name: tour_programmati tour_programmati_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_programmati
    ADD CONSTRAINT tour_programmati_pkey PRIMARY KEY (orario, anno);


--
-- Name: trattamenti_disponibili trattamenti_disponibili_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trattamenti_disponibili
    ADD CONSTRAINT trattamenti_disponibili_pkey PRIMARY KEY (nome_trattamenti);


--
-- Name: valutazioni valutazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valutazioni
    ADD CONSTRAINT valutazioni_pkey PRIMARY KEY (id);


--
-- Name: visitatori visitatori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitatori
    ADD CONSTRAINT visitatori_pkey PRIMARY KEY (username);


--
-- Name: abilitate abilitate_cod_guida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abilitate
    ADD CONSTRAINT abilitate_cod_guida_fkey FOREIGN KEY (cod_guida) REFERENCES public.guide_autorizzate(cod);


--
-- Name: abilitate abilitate_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abilitate
    ADD CONSTRAINT abilitate_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: adottano adottano_id_struttura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adottano
    ADD CONSTRAINT adottano_id_struttura_fkey FOREIGN KEY (id_struttura) REFERENCES public.strutture_ricettive(id);


--
-- Name: adottano adottano_nome_trattamenti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adottano
    ADD CONSTRAINT adottano_nome_trattamenti_fkey FOREIGN KEY (nome_trattamenti) REFERENCES public.trattamenti_disponibili(nome_trattamenti);


--
-- Name: alloggiano alloggiano_id_struttura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alloggiano
    ADD CONSTRAINT alloggiano_id_struttura_fkey FOREIGN KEY (id_struttura) REFERENCES public.strutture_ricettive(id);


--
-- Name: alloggiano alloggiano_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alloggiano
    ADD CONSTRAINT alloggiano_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- Name: centri_visita centri_visita_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centri_visita
    ADD CONSTRAINT centri_visita_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: contiene contiene_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: contiene contiene_id_segnaletica_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_id_segnaletica_fkey FOREIGN KEY (id_segnaletica) REFERENCES public.segnaletica(id);


--
-- Name: dispone_di dispone_di_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispone_di
    ADD CONSTRAINT dispone_di_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: dispone_di dispone_di_nome_certificazione_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispone_di
    ADD CONSTRAINT dispone_di_nome_certificazione_fkey FOREIGN KEY (nome_certificazione) REFERENCES public.certificazioni_possedute(nome_certificazione);


--
-- Name: effettuano effettuano_orario_anno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.effettuano
    ADD CONSTRAINT effettuano_orario_anno_fkey FOREIGN KEY (orario, anno) REFERENCES public.tour_programmati(orario, anno);


--
-- Name: effettuano effettuano_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.effettuano
    ADD CONSTRAINT effettuano_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- Name: erogano erogano_cod_centro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.erogano
    ADD CONSTRAINT erogano_cod_centro_fkey FOREIGN KEY (cod_centro) REFERENCES public.centri_visita(cod);


--
-- Name: erogano erogano_nome_servizio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.erogano
    ADD CONSTRAINT erogano_nome_servizio_fkey FOREIGN KEY (nome_servizio) REFERENCES public.servizi(nome_servizio);


--
-- Name: informano informano_cod_notizie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informano
    ADD CONSTRAINT informano_cod_notizie_fkey FOREIGN KEY (cod_notizie) REFERENCES public.notizie(cod);


--
-- Name: informano informano_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informano
    ADD CONSTRAINT informano_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: invia invia_id_richiesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invia
    ADD CONSTRAINT invia_id_richiesta_fkey FOREIGN KEY (id_richiesta) REFERENCES public.richieste_prenotazione(id);


--
-- Name: invia invia_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invia
    ADD CONSTRAINT invia_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- Name: itinerari itinerari_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itinerari
    ADD CONSTRAINT itinerari_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: notizie notizie_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notizie
    ADD CONSTRAINT notizie_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: offre offre_id_struttura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offre
    ADD CONSTRAINT offre_id_struttura_fkey FOREIGN KEY (id_struttura) REFERENCES public.strutture_ricettive(id);


--
-- Name: offre offre_nome_servizio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offre
    ADD CONSTRAINT offre_nome_servizio_fkey FOREIGN KEY (nome_servizio) REFERENCES public.servizi(nome_servizio);


--
-- Name: organizzano organizzano_cod_guida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzano
    ADD CONSTRAINT organizzano_cod_guida_fkey FOREIGN KEY (cod_guida) REFERENCES public.guide_autorizzate(cod);


--
-- Name: organizzano organizzano_orario_anno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzano
    ADD CONSTRAINT organizzano_orario_anno_fkey FOREIGN KEY (orario, anno) REFERENCES public.tour_programmati(orario, anno);


--
-- Name: possiedono possiedono_cod_guida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.possiedono
    ADD CONSTRAINT possiedono_cod_guida_fkey FOREIGN KEY (cod_guida) REFERENCES public.guide_autorizzate(cod);


--
-- Name: possiedono possiedono_nome_licenza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.possiedono
    ADD CONSTRAINT possiedono_nome_licenza_fkey FOREIGN KEY (nome_licenza) REFERENCES public.licenze(nome_licenza);


--
-- Name: presenze presenze_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presenze
    ADD CONSTRAINT presenze_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: presenze presenze_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presenze
    ADD CONSTRAINT presenze_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- Name: richieste_prenotazione richieste_prenotazione_id_struttura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.richieste_prenotazione
    ADD CONSTRAINT richieste_prenotazione_id_struttura_fkey FOREIGN KEY (id_struttura) REFERENCES public.strutture_ricettive(id);


--
-- Name: richieste_prenotazione richieste_prenotazione_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.richieste_prenotazione
    ADD CONSTRAINT richieste_prenotazione_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- Name: segnaletica segnaletica_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnaletica
    ADD CONSTRAINT segnaletica_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: segue segue_id_struttura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segue
    ADD CONSTRAINT segue_id_struttura_fkey FOREIGN KEY (id_struttura) REFERENCES public.strutture_ricettive(id);


--
-- Name: segue segue_nome_impegno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segue
    ADD CONSTRAINT segue_nome_impegno_fkey FOREIGN KEY (nome_impegno) REFERENCES public.impegni_ecologici(nome_impegno);


--
-- Name: si_possono_consultare si_possono_consultare_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.si_possono_consultare
    ADD CONSTRAINT si_possono_consultare_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: si_possono_consultare si_possono_consultare_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.si_possono_consultare
    ADD CONSTRAINT si_possono_consultare_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: strutture_ricettive strutture_ricettive_id_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strutture_ricettive
    ADD CONSTRAINT strutture_ricettive_id_parco_fkey FOREIGN KEY (id_parco) REFERENCES public.parchi(id);


--
-- Name: tour_programmati tour_programmati_cod_guida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_programmati
    ADD CONSTRAINT tour_programmati_cod_guida_fkey FOREIGN KEY (cod_guida) REFERENCES public.guide_autorizzate(cod);


--
-- Name: tour_programmati tour_programmati_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_programmati
    ADD CONSTRAINT tour_programmati_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: valutazioni valutazioni_cod_guida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valutazioni
    ADD CONSTRAINT valutazioni_cod_guida_fkey FOREIGN KEY (cod_guida) REFERENCES public.guide_autorizzate(cod);


--
-- Name: valutazioni valutazioni_id_itinerario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valutazioni
    ADD CONSTRAINT valutazioni_id_itinerario_fkey FOREIGN KEY (id_itinerario) REFERENCES public.itinerari(id);


--
-- Name: valutazioni valutazioni_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valutazioni
    ADD CONSTRAINT valutazioni_username_fkey FOREIGN KEY (username) REFERENCES public.visitatori(username);


--
-- PostgreSQL database dump complete
--

