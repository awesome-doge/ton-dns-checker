# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TON DNS Checker is a multi-service application for DNS checking capabilities within the TON (Telegram Open Network) blockchain environment. It consists of a Python FastAPI backend, React TypeScript frontend, and Redis caching layer.

## Development Commands

### Backend (Python FastAPI)
- **Start backend**: `uvicorn dnschecker.main:app --host 0.0.0.0 --port 8090`
- **Install dependencies**: `pip install -r requirements.txt`

### Frontend (React TypeScript)
- **Start development server**: `cd frontend && npm start`
- **Build for production**: `cd frontend && npm run build`
- **Install dependencies**: `cd frontend && npm install`

### Docker Development
- **Deploy with script**: `sudo bash deploy.sh`
- **Build and start all services**: `docker-compose up --build`
- **Start services in background**: `docker-compose up -d --build`

### Health Checks
- **Backend health**: `http://localhost:8090/healthcheck`
- **API documentation**: `http://localhost:8090/docs`
- **Frontend**: `http://localhost:3090`

## Architecture

### Backend (`/dnschecker`)
- **FastAPI application** (`main.py`) with CORS middleware and request logging
- **API routes** (`/api/dns.py`) providing:
  - `/dhts` - DHT node status checking
  - `/resolve` - ADNL address resolution
  - `/liteservers` - Liteserver information
  - `/ls_resolve` - Domain resolution for liteservers
- **Core services** (`/core`):
  - `dht/dht_checker.py` - DHT (Distributed Hash Table) operations
  - `dns/dns_checker.py` - DNS resolution using TON blockchain
  - `cache.py` - Redis caching layer
- **Schema models** (`/schemas`) - Pydantic models for API responses
- **Dependencies** (`/api/deps.py`) - Dependency injection for services

### Frontend (`/frontend`)
- **React TypeScript application** with Material-UI components
- **Theme system** with dark/light mode support stored in localStorage
- **React Query** for API state management
- **Notistack** for notifications

### Configuration
- **Environment variables**: Set `REACT_APP_API_URL` in `.env` file
- **Liteserver config**: Uses `private/mainnet.json` or `private/testnet.json`
- **Docker secrets**: Global config mounted from private directory

### Key Services Integration
- **Redis caching**: Containerized Redis service for performance optimization
- **TON blockchain integration**: Uses `pytonlib` for blockchain operations
- **ADNL protocol**: Handles Abstract Data Network Layer address resolution