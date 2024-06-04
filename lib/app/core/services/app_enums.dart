enum NavigationTypeEnum {
  pushAndRemoveUntil("pushAndRemoveUntil"),
  push("push"),
  pop("pop");

  final String value;
  const NavigationTypeEnum(this.value);
}

enum RoutesNameEnum {
  splash("/splash"),
  home("/"),
  tournament("/tournament"),
  resultRaffle("/result-raffle");

  final String name;
  const RoutesNameEnum(this.name);
}