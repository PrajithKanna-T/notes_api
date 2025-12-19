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
## AI Summarization Design

The AI functionality is implemented using a **service object**:

File: `app/services/notes/summarize_service.rb`

#### Responsibilities:

Accept note content

Call Ollama’s local HTTP API

Generate a concise summary

Handle failures gracefully with a fallback response

Controllers never contain AI-specific logic.

---

## API Endpoints

### Get All Notes 

**Get** `/notes`

## Get Note by ID

**Get** `/notes/id`

### Create a Note

**POST** `/notes`

### Testing the API (Windows PowerShell)

#### Request

```powershell
curl -X POST http://localhost:3000/notes `
-H "Content-Type: application/json" `
-d '{
  "note": {
    "title": "Local LLM Test",
    "content": "Rails API integrated with Ollama for summarization."
  }
}'


Response:

{
  "id": 1,
  "title": "Local LLM Test",
  "content": "Rails API integrated with Ollama for summarization.",
  "summary": "This note explains how a Rails API integrates with the Ollama local LLM to automatically generate concise summaries.",
  "created_at": "2025-12-19T06:05:42.123Z"
}

