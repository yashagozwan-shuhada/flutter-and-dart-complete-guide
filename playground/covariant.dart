void main() {
  final trainer = TrainerDog();
  trainer.display(Dog("Hubbies"));
}

class Animal {}

class Dog extends Animal {
  final String name;

  Dog(this.name);
}

abstract interface class Trainer {
  void display(covariant Animal animal);
}

class TrainerDog implements Trainer {
  @override
  void display(covariant Dog dog) {
    print(dog.name);
  }
}
