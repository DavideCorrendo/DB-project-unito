# Italian National Parks Information System

> **Note on Language:** The technical documentation (PDF) and database entities/attributes are written in Italian as part of the University Database Systems curriculum. The project overview and structural documentation are presented here in English.

Relational database design and SQL implementation developed for managing Italian national parks, hiking itineraries, tourist accommodations, and visitor analytics.

## 📌 Features
- **Parks & Areas Catalog:** Comprehensive cataloging based on official MASE classifications and sustainability certifications (CETS).
- **Trails & Guided Tours:** Trail difficulty mapping, points of interest, authorized guide licensing, and tour scheduling.
- **Accommodations & Bookings:** Lodging discovery, facility specs (group/school readiness), and reservation management.
- **Analytics & Feedback:** Visitor entry/exit tracking and multi-criteria rating mechanisms.

## 🏗️ Technical Highlights
- **Conceptual Modeling:** Formal Entity-Relationship (ER) model designed using domain-driven business rules.
- **Redundancy Analysis:** Mathematical access-cost trade-off analysis justifying materialized aggregations (e.g., average ratings) to optimize high-frequency read operations.
- **Logical Schema:** Fully normalized schema with referential integrity constraints.
- **SQL Scripts:** Declarative DDL schema setup and DML seed data containing integrity-constraint test queries.

## 📁 Repository Structure
- `sql/`: DDL schema definitions and DML seed datasets with integrity tests.
- `diagrams/`: Conceptual and restructured ER diagrams.
- `docs/`: Complete academic technical report (Italian).
