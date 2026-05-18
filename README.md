# Atlas-migration
# Atlas Database Migration Automation POC

## Objective

Automate PostgreSQL schema changes using Atlas and Jenkins with schema-as-code and CI/CD-driven migration execution.

---

## Technology Stack

- PostgreSQL
- Atlas
- Jenkins
- GitHub

---

## Workflow

Developer updates schema.hcl
        ↓
Pushes code to GitHub
        ↓
Jenkins Pipeline Triggered
        ↓
Atlas generates migration SQL
        ↓
Migration files committed automatically
        ↓
Atlas applies migrations
        ↓
PostgreSQL schema updated automatically

---

## Features Demonstrated

- Database-as-Code
- Declarative Schema Management
- Versioned Migrations
- Automated Migration Generation
- Automated Migration Deployment
- CI/CD Integration
- Migration Validation
- Migration Integrity Tracking

---

## Repository Structure

ATLAS/
├── atlas.hcl
├── Jenkinsfile
├── README.md
├── schema.hcl
└── migrations/

---

## Commands Used

Generate Migration:

atlas migrate diff auto_changes --env local

Apply Migration:

atlas migrate apply --env local
