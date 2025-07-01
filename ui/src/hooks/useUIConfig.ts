import { useState, useEffect } from 'react';
import logoBanner from '../assets/logobanner.png';

export interface UIConfig {
  vehicleImageUrl: string;
  theme: {
    defaultMode: 'light' | 'dark';
    colors: {
      light: {
        primary: string;
        secondary: string;
      };
      dark: {
        primary: string;
        secondary: string;
      };
    };
  };
  layout: {
    width: string;
    minHeight: string;
    maxHeight: string;
    vehicleCard: {
      thumbnailSize: {
        collapsed: {
          width: string;
          height: string;
        };
        expanded: {
          width: string;
          height: string;
        };
      };
    };
  };
  animations: {
    transitionDuration: string;
    hoverTransform: string;
  };
  assets: {
    logo: string;
  };
}

const defaultConfig: UIConfig = {
  vehicleImageUrl: '',
  theme: {
    defaultMode: 'dark',
    colors: {
      light: {
        primary: '#5fbc60',
        secondary: '#004a00'
      },
      dark: {
        primary: '#004a00',
        secondary: '#5fbc60'
      }
    }
  },
  layout: {
    width: '50vw',
    minHeight: '50vh',
    maxHeight: '80vh',
    vehicleCard: {
      thumbnailSize: {
        collapsed: {
          width: '4rem',
          height: '3rem'
        },
        expanded: {
          width: '8rem',
          height: '6rem'
        }
      }
    }
  },
  animations: {
    transitionDuration: '0.3s',
    hoverTransform: 'translateY(-0.125rem)'
  },
  assets: {
    logo: logoBanner
  }
};

export const useUIConfig = () => {
  const [config, setConfig] = useState<UIConfig>(defaultConfig);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const loadConfig = async () => {
      try {
        const response = await fetch('./ui-config.json');
        if (!response.ok) {
          throw new Error(`Failed to load config: ${response.status}`);
        }
        const jsonConfig = await response.json();
        setConfig({ ...defaultConfig, ...jsonConfig });
        setError(null);
      } catch (err) {
        console.warn('Failed to load UI config, using defaults:', err);
        setError(err instanceof Error ? err.message : 'Unknown error');
        setConfig(defaultConfig);
      } finally {
        setLoading(false);
      }
    };

    loadConfig();
  }, []);

  const getVehicleImageUrl = (vehicleModel: string): string => {
    if (!config.vehicleImageUrl) return '';
    return config.vehicleImageUrl.replace('{vehicleModel}', vehicleModel.toLowerCase());
  };

  return {
    config,
    loading,
    error,
    getVehicleImageUrl
  };
};
