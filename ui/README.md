# Garage UI Setup

This is a modern React-based UI for the garage system, built with Vite 7.0.0 and Material-UI.

## Features

- **Dark/Light Theme**: Toggle between dark (#004a00) and light (#5fbc60) green themes
- **Responsive Design**: Scales consistently across different resolutions (50% width, 50-80% height)
- **Material Icons**: Garage type icons (car, aircraft, boat, impound)
- **Vehicle Cards**: Collapsible cards showing vehicle details and stats
- **Progress Bars**: Fuel, engine, body health, and vehicle performance stats
- **Action Buttons**: Take Out, Lend, Give, Sell functionality

## Setup Instructions

### 1. Install Dependencies

Navigate to the UI directory and install dependencies:

```bash
cd ui
npm install
```

### 2. Build the UI

For production:
```bash
npm run build
```

For development with auto-rebuild:
```bash
npm run build:watch
```

### 3. Configuration



### 4. Assets

- Place your logo at `ui/public/assets/logo.svg`
- Vehicle images can be added to `ui/public/assets/vehicles/`
- Update vehicle image URLs in the server data

## UI Structure

```
ui/
├── public/
│   └── assets/
│       ├── logo.svg          # Your logo for theme toggle
│       └── vehicles/         # Vehicle images
├── src/
│   ├── components/
│   │   ├── GarageApp.tsx     # Main garage component
│   │   └── VehicleCard.tsx   # Individual vehicle cards
│   ├── hooks/
│   │   ├── useTheme.ts       # Theme management
│   │   └── useGarageData.ts  # Data management
│   ├── types/
│   │   └── index.ts          # TypeScript interfaces
│   ├── assets/
│   │   └── defaultVehicle.ts # Default vehicle image
│   ├── theme.ts              # Material-UI theme configuration
│   ├── index.css             # Global styles
│   └── main.tsx              # Entry point
├── dist/                     # Built files (auto-generated)
├── package.json
├── vite.config.ts
└── ui.html                   # NUI entry point
```

## Theme Customization

The themes use your specified colors:

- **Dark Theme**: Primary #004a00 (00 74 00)
- **Light Theme**: Primary #5fbc60 (95 188 96)

To modify colors, edit `src/theme.ts`.

## NUI Callbacks

The UI sends these callbacks to the Lua client:

- `closeGarage`: Close the garage UI
- `takeOutVehicle`: Take out a vehicle
- `lendVehicle`: Lend vehicle to another player
- `giveVehicle`: Give vehicle to another player
- `sellVehicle`: Sell the vehicle

## Development

For development with hot reload:
```bash
npm run dev
```

Then open http://localhost:3000 to see the UI in browser.

## Integration Notes

- The UI is integrated into the existing garage system
- Vehicle data is automatically formatted from the server
- Progress bars show fuel, engine, and body health
- Vehicle stats are displayed with progress bars
- All buttons are functional and send appropriate callbacks

## Troubleshooting

1. **UI not showing**: Ensure `npm run build` completed successfully
2. **Theme not changing**: Check that logo.svg exists in public/assets/
3. **No vehicle images**: Add default images or ensure URLs are correct
4. **Callbacks not working**: Verify client/ui.lua is loaded in fxmanifest.lua
