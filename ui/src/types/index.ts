export interface Vehicle {
  id: string;
  name: string;
  model: string;
  plate: string;
  fuel: number;
  engine: number;
  body: number;
  stats: VehicleStats;
  garage: string;
  state: 'OUT' | 'GARAGED' | 'IMPOUNDED';
}

export interface VehicleStats {
  maxSpeed: number;
  acceleration: number;
  braking: number;
  traction: number;
  suspension: number;
}

export interface GarageData {
  name: string;
  type: 'car' | 'air' | 'sea' | 'impound';
  vehicles: Vehicle[];
  totalCount: number;
}

export type ThemeMode = 'light' | 'dark';
