enum NavigationTypeEnum {
  pushAndRemoveUntil("pushAndRemoveUntil"),
  push("push"),
  pop("pop");

  final String value;
  const NavigationTypeEnum(this.value);
}