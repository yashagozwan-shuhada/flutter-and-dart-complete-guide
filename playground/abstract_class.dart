void main() {
  final grind = EnergyGrid();
  final nuclear = NuclearPlant();
  final solar = SolarPlant();

  grind.addPlant(nuclear);
  grind.addPlant(solar);
}

class EnergyGrid {
  final List<PowerPlant> plants = [];

  void addPlant(PowerPlant plant) {
    plant.turnOn("5 hours");
    plants.add(plant);
  }
}

abstract interface class PowerPlant {
  final int costOfEnergy = 0;

  bool turnOn(String duration);
}

abstract interface class Building {
  Building(this.height);

  final int height;
}

class NuclearPlant implements PowerPlant, Building {
  @override
  bool turnOn(String duration) {
    print("i am a nuclear plant turning on");
    return true;
  }

  @override
  int get costOfEnergy => 10;

  @override
  int get height => 50;
}

class SolarPlant implements PowerPlant {
  @override
  bool turnOn(String duration) {
    print("i am a solar plant turning on");
    return false;
  }

  @override
  int get costOfEnergy => 15;
}
