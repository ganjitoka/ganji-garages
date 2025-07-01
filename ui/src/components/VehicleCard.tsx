import React from "react";
import {
  Card,
  CardContent,
  Box,
  Typography,
  LinearProgress,
  Button,
  IconButton,
  Grid,
  Chip,
} from "@mui/material";
import {
  ExpandMore,
  DirectionsCar,
  MonetizationOn,
  PersonAdd,
  Handshake,
} from "@mui/icons-material";
import { Vehicle } from "../types";
import defaultVehicleImage from "../assets/defaultVehicle";

interface VehicleCardProps {
  vehicle: Vehicle;
  getVehicleImageUrl: (model: string) => string;
  onTakeOut: (vehicleId: string) => void;
  onLend: (vehicleId: string) => void;
  onGive: (vehicleId: string) => void;
  onSell: (vehicleId: string) => void;
}

const VehicleCard: React.FC<VehicleCardProps> = ({
  vehicle,
  getVehicleImageUrl,
  onTakeOut,
  onLend,
  onGive,
  onSell,
}) => {
  const [expanded, setExpanded] = React.useState(false);
  const [imageSrc, setImageSrc] = React.useState(
    getVehicleImageUrl(vehicle.model) || defaultVehicleImage
  );

  // Update image source when vehicle changes
  React.useEffect(() => {
    setImageSrc(getVehicleImageUrl(vehicle.model) || defaultVehicleImage);
  }, [vehicle.model, getVehicleImageUrl]);

  const handleImageError = () => {
    setImageSrc(defaultVehicleImage);
  };

  const getProgressColor = (value: number) => {
    if (value >= 75) return "success";
    if (value > 25) return "warning";
    return "error";
  };

  const formatStatValue = (value: number) => `${value}%`;

  return (
    <Card
      sx={{
        mb: "1rem",
        bgcolor: "background.paper",
        borderRadius: "0.75rem",
        overflow: "hidden",
        transition: "all 0.2s ease-in-out",
        "&:hover": {
          transform: "translateY(-0.125rem)",
          boxShadow: 4,
        },
      }}
    >
      <CardContent sx={{ p: expanded ? "1rem" : "0.75rem" }}>
        {/* Collapsed/Compact View */}
        {!expanded && (
          <Box sx={{ display: "flex", alignItems: "center", gap: "1rem" }}>
            {/* Vehicle Thumbnail */}
            <Box
              sx={{
                width: "3.5rem",
                height: "2.5rem",
                borderRadius: "0.5rem",
                overflow: "hidden",
                flexShrink: 0,
                bgcolor: "grey.200",
              }}
            >
              <img
                src={imageSrc}
                alt={vehicle.name}
                onError={handleImageError}
                style={{
                  width: "100%",
                  height: "100%",
                  objectFit: "cover",
                }}
              />
            </Box>

            {/* Vehicle Info */}
            <Box sx={{ flex: "0 1 auto", minWidth: "8rem" }}>
              <Typography
                variant="subtitle1"
                sx={{
                  fontWeight: 600,
                  fontSize: "0.95rem",
                  lineHeight: 1.2,
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                }}
              >
                {vehicle.name}
              </Typography>
              <Typography
                variant="caption"
                sx={{
                  color: "text.secondary",
                  fontSize: "0.75rem",
                  fontWeight: 500,
                }}
              >
                {vehicle.plate}
              </Typography>
            </Box>

            {/* Compact Health Bars */}
            <Box
              sx={{
                display: "flex",
                alignItems: "center",
                gap: "0.75rem",
                flex: "1 1 auto",
                minWidth: "12rem",
              }}
            >
              {/* Fuel */}
              <Box
                sx={{
                  display: "flex",
                  alignItems: "center",
                  gap: "0.5rem",
                  flex: 1,
                }}
              >
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2.5rem",
                    fontSize: "0.7rem",
                    color: "text.secondary",
                    fontWeight: 500,
                  }}
                >
                  Fuel
                </Typography>
                <LinearProgress
                  variant="determinate"
                  value={vehicle.fuel}
                  color={getProgressColor(vehicle.fuel)}
                  sx={{
                    flex: 1,
                    height: "0.4rem",
                    borderRadius: "0.2rem",
                    bgcolor: "grey.200",
                    maxWidth: "4rem",
                  }}
                />
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2rem",
                    fontSize: "0.7rem",
                    fontWeight: 500,
                    textAlign: "right",
                  }}
                >
                  {vehicle.fuel}%
                </Typography>
              </Box>

              {/* Engine */}
              <Box
                sx={{
                  display: "flex",
                  alignItems: "center",
                  gap: "0.5rem",
                  flex: 1,
                }}
              >
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2.5rem",
                    fontSize: "0.7rem",
                    color: "text.secondary",
                    fontWeight: 500,
                  }}
                >
                  Engine
                </Typography>
                <LinearProgress
                  variant="determinate"
                  value={vehicle.engine}
                  color={getProgressColor(vehicle.engine)}
                  sx={{
                    flex: 1,
                    height: "0.4rem",
                    borderRadius: "0.2rem",
                    bgcolor: "grey.200",
                    maxWidth: "4rem",
                  }}
                />
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2rem",
                    fontSize: "0.7rem",
                    fontWeight: 500,
                    textAlign: "right",
                  }}
                >
                  {vehicle.engine}%
                </Typography>
              </Box>

              {/* Body */}
              <Box
                sx={{
                  display: "flex",
                  alignItems: "center",
                  gap: "0.5rem",
                  flex: 1,
                }}
              >
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2.5rem",
                    fontSize: "0.7rem",
                    color: "text.secondary",
                    fontWeight: 500,
                  }}
                >
                  Body
                </Typography>
                <LinearProgress
                  variant="determinate"
                  value={vehicle.body}
                  color={getProgressColor(vehicle.body)}
                  sx={{
                    flex: 1,
                    height: "0.4rem",
                    borderRadius: "0.2rem",
                    bgcolor: "grey.200",
                    maxWidth: "4rem",
                  }}
                />
                <Typography
                  variant="caption"
                  sx={{
                    minWidth: "2rem",
                    fontSize: "0.7rem",
                    fontWeight: 500,
                    textAlign: "right",
                  }}
                >
                  {vehicle.body}%
                </Typography>
              </Box>
            </Box>

            {/* Actions */}
            <Box
              sx={{
                display: "flex",
                alignItems: "center",
                gap: "0.5rem",
                flexShrink: 0,
              }}
            >
              <Button
                variant="contained"
                startIcon={<DirectionsCar />}
                onClick={() => onTakeOut(vehicle.id)}
                sx={{
                  minWidth: "10rem",
                  width: "10rem",
                  fontSize: "0.8rem",
                  py: "0.6rem",
                  px: "1.2rem",
                  height: "2.5rem",
                  borderRadius: "4px", // Less rounded corners
                }}
              >
                Take Out
              </Button>
              <IconButton
                onClick={() => setExpanded(!expanded)}
                size="small"
                sx={{
                  bgcolor: "action.hover",
                  "&:hover": {
                    bgcolor: "action.selected",
                  },
                }}
              >
                <ExpandMore />
              </IconButton>
            </Box>
          </Box>
        )}

        {/* Expanded View */}
        {expanded && (
          <Box>
            <Box
              sx={{
                display: "flex",
                alignItems: "center",
                gap: "1rem",
                mb: "1rem",
              }}
            >
              {/* Vehicle Thumbnail - Larger in expanded mode */}
              <Box
                sx={{
                  width: "8rem",
                  height: "6rem",
                  borderRadius: "0.5rem",
                  overflow: "hidden",
                  flexShrink: 0,
                  bgcolor: "grey.200",
                }}
              >
                <img
                  src={imageSrc}
                  alt={vehicle.name}
                  onError={handleImageError}
                  style={{
                    width: "100%",
                    height: "100%",
                    objectFit: "cover",
                  }}
                />
              </Box>

              {/* Vehicle Info */}
              <Box sx={{ flex: 1, minWidth: 0 }}>
                <Typography
                  variant="h6"
                  sx={{
                    fontWeight: 600,
                    fontSize: "1.1rem",
                    mb: "0.5rem",
                    overflow: "hidden",
                    textOverflow: "ellipsis",
                    whiteSpace: "nowrap",
                  }}
                >
                  {vehicle.name}
                </Typography>
                <Chip
                  label={vehicle.plate}
                  size="small"
                  sx={{
                    fontSize: "0.75rem",
                    height: "1.5rem",
                    mb: "1rem",
                    fontWeight: 600,
                  }}
                />

                {/* Health Status */}
                <Box
                  sx={{
                    display: "flex",
                    flexDirection: "column",
                    gap: "0.75rem",
                  }}
                >
                  <Box
                    sx={{ display: "flex", alignItems: "center", gap: "1rem" }}
                  >
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "4rem",
                        fontSize: "0.85rem",
                        fontWeight: 500,
                      }}
                    >
                      Fuel
                    </Typography>
                    <LinearProgress
                      variant="determinate"
                      value={vehicle.fuel}
                      color={getProgressColor(vehicle.fuel)}
                      sx={{ flex: 1, height: "0.6rem", borderRadius: "0.3rem" }}
                    />
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "3rem",
                        fontSize: "0.85rem",
                        fontWeight: 600,
                      }}
                    >
                      {vehicle.fuel}%
                    </Typography>
                  </Box>
                  <Box
                    sx={{ display: "flex", alignItems: "center", gap: "1rem" }}
                  >
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "4rem",
                        fontSize: "0.85rem",
                        fontWeight: 500,
                      }}
                    >
                      Engine
                    </Typography>
                    <LinearProgress
                      variant="determinate"
                      value={vehicle.engine}
                      color={getProgressColor(vehicle.engine)}
                      sx={{ flex: 1, height: "0.6rem", borderRadius: "0.3rem" }}
                    />
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "3rem",
                        fontSize: "0.85rem",
                        fontWeight: 600,
                      }}
                    >
                      {vehicle.engine}%
                    </Typography>
                  </Box>
                  <Box
                    sx={{ display: "flex", alignItems: "center", gap: "1rem" }}
                  >
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "4rem",
                        fontSize: "0.85rem",
                        fontWeight: 500,
                      }}
                    >
                      Body
                    </Typography>
                    <LinearProgress
                      variant="determinate"
                      value={vehicle.body}
                      color={getProgressColor(vehicle.body)}
                      sx={{ flex: 1, height: "0.6rem", borderRadius: "0.3rem" }}
                    />
                    <Typography
                      variant="body2"
                      sx={{
                        minWidth: "3rem",
                        fontSize: "0.85rem",
                        fontWeight: 600,
                      }}
                    >
                      {vehicle.body}%
                    </Typography>
                  </Box>
                </Box>
              </Box>

              {/* Collapse Button */}
              <IconButton
                onClick={() => setExpanded(!expanded)}
                sx={{
                  alignSelf: "flex-start",
                  transform: "rotate(180deg)",
                  bgcolor: "action.hover",
                  "&:hover": {
                    bgcolor: "action.selected",
                  },
                }}
              >
                <ExpandMore />
              </IconButton>
            </Box>

            {/* Vehicle Stats and Actions - Expanded */}
            <Box
              sx={{
                mt: "1rem",
                pt: "1rem",
                borderTop: 1,
                borderColor: "divider",
              }}
            >
              <Grid container spacing={2}>
                {/* Vehicle Stats */}
                <Grid item xs={12} md={8}>
                  <Typography
                    variant="subtitle2"
                    sx={{ mb: "0.75rem", fontWeight: 600 }}
                  >
                    Vehicle Statistics
                  </Typography>
                  <Grid container spacing={1}>
                    <Grid item xs={6}>
                      <Box
                        sx={{
                          display: "flex",
                          alignItems: "center",
                          gap: "0.5rem",
                          mb: "0.5rem",
                        }}
                      >
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "4rem", fontSize: "0.75rem" }}
                        >
                          Max Speed
                        </Typography>
                        <LinearProgress
                          variant="determinate"
                          value={vehicle.stats.maxSpeed}
                          sx={{
                            flex: 1,
                            height: "0.5rem",
                            borderRadius: "0.25rem",
                          }}
                        />
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "2rem", fontSize: "0.75rem" }}
                        >
                          {formatStatValue(vehicle.stats.maxSpeed)}
                        </Typography>
                      </Box>
                      <Box
                        sx={{
                          display: "flex",
                          alignItems: "center",
                          gap: "0.5rem",
                          mb: "0.5rem",
                        }}
                      >
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "4rem", fontSize: "0.75rem" }}
                        >
                          Acceleration
                        </Typography>
                        <LinearProgress
                          variant="determinate"
                          value={vehicle.stats.acceleration}
                          sx={{
                            flex: 1,
                            height: "0.5rem",
                            borderRadius: "0.25rem",
                          }}
                        />
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "2rem", fontSize: "0.75rem" }}
                        >
                          {formatStatValue(vehicle.stats.acceleration)}
                        </Typography>
                      </Box>
                      <Box
                        sx={{
                          display: "flex",
                          alignItems: "center",
                          gap: "0.5rem",
                        }}
                      >
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "4rem", fontSize: "0.75rem" }}
                        >
                          Braking
                        </Typography>
                        <LinearProgress
                          variant="determinate"
                          value={vehicle.stats.braking}
                          sx={{
                            flex: 1,
                            height: "0.5rem",
                            borderRadius: "0.25rem",
                          }}
                        />
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "2rem", fontSize: "0.75rem" }}
                        >
                          {formatStatValue(vehicle.stats.braking)}
                        </Typography>
                      </Box>
                    </Grid>
                    <Grid item xs={6}>
                      <Box
                        sx={{
                          display: "flex",
                          alignItems: "center",
                          gap: "0.5rem",
                          mb: "0.5rem",
                        }}
                      >
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "4rem", fontSize: "0.75rem" }}
                        >
                          Traction
                        </Typography>
                        <LinearProgress
                          variant="determinate"
                          value={vehicle.stats.traction}
                          sx={{
                            flex: 1,
                            height: "0.5rem",
                            borderRadius: "0.25rem",
                          }}
                        />
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "2rem", fontSize: "0.75rem" }}
                        >
                          {formatStatValue(vehicle.stats.traction)}
                        </Typography>
                      </Box>
                      <Box
                        sx={{
                          display: "flex",
                          alignItems: "center",
                          gap: "0.5rem",
                        }}
                      >
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "4rem", fontSize: "0.75rem" }}
                        >
                          Suspension
                        </Typography>
                        <LinearProgress
                          variant="determinate"
                          value={vehicle.stats.suspension}
                          sx={{
                            flex: 1,
                            height: "0.5rem",
                            borderRadius: "0.25rem",
                          }}
                        />
                        <Typography
                          variant="caption"
                          sx={{ minWidth: "2rem", fontSize: "0.75rem" }}
                        >
                          {formatStatValue(vehicle.stats.suspension)}
                        </Typography>
                      </Box>
                    </Grid>
                  </Grid>
                </Grid>

                {/* Additional Actions */}
                <Grid item xs={12} md={4}>
                  <Typography
                    variant="subtitle2"
                    sx={{ mb: "0.75rem", fontWeight: 600 }}
                  >
                    Actions
                  </Typography>
                  <Box
                    sx={{
                      display: "flex",
                      flexDirection: "column",
                      gap: "0.5rem",
                    }}
                  >
                    <Button
                      variant="contained"
                      startIcon={<DirectionsCar />}
                      onClick={() => onTakeOut(vehicle.id)}
                      fullWidth
                      sx={{
                        fontSize: "0.8rem",
                        borderRadius: "4px",
                        height: "2.5rem",
                      }}
                    >
                      Take Out
                    </Button>
                    <Button
                      variant="outlined"
                      startIcon={<Handshake />}
                      onClick={() => onLend(vehicle.id)}
                      fullWidth
                      sx={{
                        fontSize: "0.8rem",
                        borderRadius: "4px",
                        height: "2.5rem",
                      }}
                    >
                      Lend
                    </Button>
                    <Button
                      variant="outlined"
                      startIcon={<PersonAdd />}
                      onClick={() => onGive(vehicle.id)}
                      fullWidth
                      sx={{
                        fontSize: "0.8rem",
                        borderRadius: "4px",
                        height: "2.5rem",
                      }}
                    >
                      Give
                    </Button>
                    <Button
                      variant="outlined"
                      startIcon={<MonetizationOn />}
                      onClick={() => onSell(vehicle.id)}
                      fullWidth
                      sx={{
                        fontSize: "0.8rem",
                        borderRadius: "4px",
                        height: "2.5rem",
                      }}
                    >
                      Sell
                    </Button>
                  </Box>
                </Grid>
              </Grid>
            </Box>
          </Box>
        )}
      </CardContent>
    </Card>
  );
};

export default VehicleCard;
