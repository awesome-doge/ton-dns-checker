# TON DNS Checker

A comprehensive application for DNS checking capabilities within the TON (Telegram Open Network) blockchain ecosystem. The application features a FastAPI backend with Redis caching and a React TypeScript frontend for seamless user interaction.

## Features

- **DHT Node Status Monitoring**: Real-time status checking of Distributed Hash Table (DHT) nodes across the TON network
- **ADNL Address Resolution**: Resolve Abstract Data Network Layer (ADNL) addresses to their corresponding network information
- **Liteserver Management**: Retrieve and monitor TON liteserver information and connectivity status
- **Domain Resolution**: Resolve TON domains (.ton) to various resources including sites and wallet addresses
- **Caching Layer**: Redis-powered caching for improved performance and reduced blockchain queries

## Architecture

The application consists of three main components:

- **Backend API**: FastAPI service providing REST endpoints for TON network operations
- **Frontend Interface**: React TypeScript application with Material-UI components
- **Cache Layer**: Redis service for optimized data retrieval and storage

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git
- Basic familiarity with TON blockchain concepts

### Quick Start

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd ton-dns-checker
   ```

2. **Environment Setup**

   Create a `.env` file in the project root:

   ```env
   REACT_APP_API_URL="http://localhost:8090"
   ```

3. **Deploy with Script** (Recommended)

   ```bash
   sudo bash deploy.sh
   ```

   Or manually with Docker Compose:

   ```bash
   docker-compose up --build
   ```

### Service Access

After deployment, the following services will be available:

- **API Documentation**: `http://localhost:8090/docs` - Interactive Swagger/OpenAPI documentation
- **Frontend Interface**: `http://localhost:3090` - Web application interface
- **Health Check**: `http://localhost:8090/healthcheck` - Service health verification

## API Endpoints

The application provides the following REST endpoints:

- `GET /dhts` - Retrieve DHT node status information
- `GET /resolve?adnl=<address>` - Resolve ADNL addresses
- `GET /liteservers` - Get liteserver information
- `GET /ls_resolve?domain=<domain>&category=<type>` - Resolve TON domains

## Development

### Backend Development

```bash
# Install Python dependencies
pip install -r requirements.txt

# Run development server
uvicorn dnschecker.main:app --host 0.0.0.0 --port 8090 --reload
```

### Frontend Development

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

## Configuration

### Environment Variables

- `REACT_APP_API_URL`: API endpoint URL for frontend communication
- `TON_LITESERVER_CONFIG`: Path to TON network configuration file (defaults to `private/mainnet.json`)

### Network Configuration

The application uses TON network configuration files located in the `private/` directory:

- `mainnet.json` - Production TON network configuration
- `testnet.json` - Test TON network configuration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.