import { createTheme } from '@mui/material/styles';
import { UIConfig } from './hooks/useUIConfig';

export const createLightTheme = (config: UIConfig) => createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: config.theme.colors.light.primary,
      contrastText: '#ffffff',
    },
    secondary: {
      main: config.theme.colors.light.secondary,
      contrastText: '#ffffff',
    },
    background: {
      default: 'transparent',
      paper: '#ffffff',
    },
    text: {
      primary: '#000000',
      secondary: '#666666',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
  },
});

export const createDarkTheme = (config: UIConfig) => createTheme({
  palette: {
    mode: 'dark',
    primary: {
      main: config.theme.colors.dark.primary,
      contrastText: '#ffffff',
    },
    secondary: {
      main: config.theme.colors.dark.secondary,
      contrastText: '#000000',
    },
    background: {
      default: 'transparent',
      paper: '#1e1e1e',
    },
    text: {
      primary: '#ffffff',
      secondary: '#cccccc',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
  },
});
