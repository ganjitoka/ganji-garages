import React from "react";
import {
  ThemeProvider,
  Box,
  Typography,
  IconButton,
  Divider,
} from "@mui/material";
import {
  Close,
  DirectionsCar,
  Flight,
  DirectionsBoat,
  Build,
} from "@mui/icons-material";
import { createLightTheme, createDarkTheme } from "../theme";
import { useTheme } from "../hooks/useTheme";
import { useGarageData } from "../hooks/useGarageData";
import { useUIConfig } from "../hooks/useUIConfig";
import VehicleCard from "./VehicleCard";

const getGarageIcon = (type: string) => {
  switch (type) {
    case "car":
      return <DirectionsCar />;
    case "air":
      return <Flight />;
    case "sea":
      return <DirectionsBoat />;
    case "impound":
      return <Build />;
    default:
      return <DirectionsCar />;
  }
};

const GarageApp: React.FC = () => {
  const [isVisible, setIsVisible] = React.useState(false);
  const { mode, toggleTheme } = useTheme();
  const { config, getVehicleImageUrl } = useUIConfig();
  const {
    garageData,
    isLoading,
    takeOutVehicle,
    lendVehicle,
    giveVehicle,
    sellVehicle,
  } = useGarageData();

  // Create themes using config
  const lightTheme = React.useMemo(() => createLightTheme(config), [config]);
  const darkTheme = React.useMemo(() => createDarkTheme(config), [config]);
  const currentTheme = mode === "light" ? lightTheme : darkTheme;

  // Listen for NUI show/hide messages
  React.useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.data.type === "UPDATE_GARAGE_DATA") {
        setIsVisible(true);
      } else if (event.data.type === "HIDE_GARAGE") {
        setIsVisible(false);
      }
    };

    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape" && isVisible) {
        closeGarage();
      }
    };

    window.addEventListener("message", handleMessage);
    document.addEventListener("keydown", handleKeyDown);

    return () => {
      window.removeEventListener("message", handleMessage);
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [isVisible]);

  const closeGarage = () => {
    const resourceName =
      (window as any).GetParentResourceName?.() || "ganji-garages";
    fetch(`https://${resourceName}/closeGarage`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({}),
    });
    setIsVisible(false);
  };

  if (!isVisible) {
    return null;
  }

  return (
    <ThemeProvider theme={currentTheme}>
      <Box
        sx={{
          position: "fixed",
          top: "50%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          width: "50vw",
          minHeight: "50vh",
          maxHeight: "80vh",
          backgroundColor: "background.paper",
          borderRadius: "1rem",
          boxShadow: 24,
          display: "flex",
          flexDirection: "column",
          overflow: "hidden",
          pointerEvents: "auto",
        }}
      >
        {/* Header */}
        <Box
          sx={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            p: "1.5rem",
            backgroundColor: "primary.main",
            color: "primary.contrastText",
          }}
        >
          <Box sx={{ display: "flex", alignItems: "center", gap: "0.75rem" }}>
            {getGarageIcon(garageData.type)}
            <Typography variant="h5" sx={{ fontWeight: 600 }}>
              {garageData.name}
            </Typography>
          </Box>
          <IconButton
            onClick={closeGarage}
            sx={{ color: "primary.contrastText" }}
          >
            <Close />
          </IconButton>
        </Box>

        {/* Body */}
        <Box
          sx={{
            flex: 1,
            overflow: "auto",
            p: "1rem",
            "&::-webkit-scrollbar": {
              width: "0.5rem",
            },
            "&::-webkit-scrollbar-track": {
              backgroundColor: "rgba(0,0,0,0.1)",
              borderRadius: "0.25rem",
            },
            "&::-webkit-scrollbar-thumb": {
              backgroundColor: "rgba(0,0,0,0.3)",
              borderRadius: "0.25rem",
              "&:hover": {
                backgroundColor: "rgba(0,0,0,0.4)",
              },
            },
          }}
        >
          {isLoading ? (
            <Box
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                height: "20rem",
              }}
            >
              <Typography variant="h6" color="text.secondary">
                Loading vehicles...
              </Typography>
            </Box>
          ) : garageData.vehicles.length === 0 ? (
            <Box
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                height: "20rem",
                flexDirection: "column",
                gap: "1rem",
              }}
            >
              <DirectionsCar
                sx={{ fontSize: "4rem", color: "text.secondary" }}
              />
              <Typography variant="h6" color="text.secondary">
                No vehicles in this garage
              </Typography>
            </Box>
          ) : (
            garageData.vehicles.map((vehicle) => (
              <VehicleCard
                key={vehicle.id}
                vehicle={vehicle}
                getVehicleImageUrl={getVehicleImageUrl}
                onTakeOut={takeOutVehicle}
                onLend={lendVehicle}
                onGive={giveVehicle}
                onSell={sellVehicle}
              />
            ))
          )}
        </Box>

        <Divider />

        {/* Footer */}
        <Box
          sx={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            p: "1rem",
            backgroundColor: "background.default",
          }}
        >
          <Typography variant="body2" color="text.secondary">
            {garageData.totalCount}{" "}
            {garageData.totalCount === 1 ? "vehicle" : "vehicles"} stored
          </Typography>
          <IconButton
            onClick={toggleTheme}
            sx={{
              width: "2.5rem",
              height: "2.5rem",
              backgroundColor: "primary.main",
              color: "primary.contrastText",
              "&:hover": {
                backgroundColor: "primary.dark",
              },
            }}
          >
            {/* Logo */}
            <Box
              component="img"
              src={config.assets.logo}
              alt="Logo"
              sx={{
                width: "1.5rem",
                height: "1.5rem",
              }}
              onError={(e) => {
                // Fallback to theme toggle icon if logo not found
                (e.target as HTMLImageElement).style.display = "none";
                ((e.target as HTMLImageElement)
                  .nextElementSibling as HTMLElement)!.style.display = "block";
              }}
            />
            <Typography
              variant="caption"
              sx={{
                display: "none",
                fontSize: "0.7rem",
                fontWeight: 600,
              }}
            >
              {mode === "light" ? "🌙" : "☀️"}
            </Typography>
          </IconButton>
        </Box>
      </Box>
    </ThemeProvider>
  );
};

export default GarageApp;
