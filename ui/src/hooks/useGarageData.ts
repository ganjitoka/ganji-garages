import { useState, useEffect } from 'react';
import { GarageData } from '../types';

export const useGarageData = () => {
  const [garageData, setGarageData] = useState<GarageData>({
    name: 'Legion Square',
    type: 'car',
    vehicles: [],
    totalCount: 0,
  });
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    // Listen for NUI messages
    const handleMessage = (event: MessageEvent) => {
      if (event.data.type === 'UPDATE_GARAGE_DATA') {
        setGarageData(event.data.data);
        setIsLoading(false);
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, []);

  const takeOutVehicle = (vehicleId: string) => {
    // Send NUI callback to take out vehicle
    const resourceName = (window as any).GetParentResourceName?.() || 'ganji-garages';
    fetch(`https://${resourceName}/takeOutVehicle`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ vehicleId }),
    });
  };

  const lendVehicle = (vehicleId: string) => {
    const resourceName = (window as any).GetParentResourceName?.() || 'ganji-garages';
    fetch(`https://${resourceName}/lendVehicle`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ vehicleId }),
    });
  };

  const giveVehicle = (vehicleId: string) => {
    const resourceName = (window as any).GetParentResourceName?.() || 'ganji-garages';
    fetch(`https://${resourceName}/giveVehicle`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ vehicleId }),
    });
  };

  const sellVehicle = (vehicleId: string) => {
    const resourceName = (window as any).GetParentResourceName?.() || 'ganji-garages';
    fetch(`https://${resourceName}/sellVehicle`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ vehicleId }),
    });
  };

  return {
    garageData,
    isLoading,
    takeOutVehicle,
    lendVehicle,
    giveVehicle,
    sellVehicle,
  };
};
