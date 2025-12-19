# Notes API – Rails with Local LLM (Ollama)

A production-ready **Ruby on Rails API** that enables users to create notes and automatically generate concise summaries using a **local Large Language Model (LLM)** powered by **Ollama**.  
This project demonstrates clean API design, service-object architecture, and local AI integration without relying on third-party cloud APIs.

---

---

## Summary

This application exposes RESTful endpoints to manage notes.  
Each note includes a title and content, and a summary is automatically generated using a locally hosted LLM.  
The AI logic is isolated using a service object to ensure maintainability and scalability.

---

## Features

- Create notes via REST API
- Automatic AI-generated summaries
- Retrieve all notes
- Retrieve individual notes by ID
- Clean separation of concerns
- Local LLM usage (no external API keys)

---

## Tech Stack

- Ruby 3.4+
- Ruby on Rails 8 (API-only)
- SQLite (development)
- Ollama (local LLM runtime)
- Mistral / LLaMA / Gemma models

---

## Architecture

- **Controller Layer**: Handles HTTP requests and responses
- **Model Layer**: Validations and persistence
- **Service Layer**: Encapsulates AI summarization logic
- **Local AI Runtime**: Ollama accessed via HTTP

This structure keeps controllers minimal and business logic reusable.

---

## Data Model

### Note

| Attribute | Type | Description |
|--------|------|-------------|
| id | integer | Primary key |
| title | string | Required |
| content | text | Required |
| summary | text | AI-generated |
| created_at | datetime | Auto-generated |

---

## API Endpoints

## API Endpoints

### Create a Note

**POST** `/notes`

#### Request

```json
{
  "note": {
    "title": "My first note",
    "content": "This is a long paragraph that needs summarizing..."
  }
}

