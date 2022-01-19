class CharacterDto {
  String? name;
  List<Attributes>? attributes;
  String? image;

  CharacterDto({this.name, this.attributes, this.image});

  CharacterDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    return data;
  }

  String? get classe => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.classe)
      .value;
  String? get rarity => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.rarity)
      .value;
  Attributes? get height => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.height);
  String? get preferredFoot => attributes
      ?.singleWhere(
          (element) => element.traitType == TraitTypeNames.preferredFoot)
      .value;
  String? get position => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.position)
      .value;
  Attributes? get attack => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.attack);
  Attributes? get defense => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.defense);
  Attributes? get creativity => attributes?.singleWhere(
      (element) => element.traitType == TraitTypeNames.creativity);
  Attributes? get tactic => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.tactic);
  Attributes? get technique => attributes
      ?.singleWhere((element) => element.traitType == TraitTypeNames.technique);
  Attributes? get preferredNumber => attributes?.singleWhere(
      (element) => element.traitType == TraitTypeNames.preferredNumber);
}

class Attributes {
  String? traitType;
  dynamic value;
  int? maxValue;
  String? displayType;

  Attributes({this.traitType, this.value, this.maxValue, this.displayType});

  Attributes.fromJson(Map<String, dynamic> json) {
    traitType = json['trait_type'];
    value = json['value'];
    maxValue = json['max_value'];
    displayType = json['display_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trait_type'] = traitType;
    data['value'] = value;
    data['max_value'] = maxValue;
    data['display_type'] = displayType;
    return data;
  }
}

class TraitTypeNames {
  static const classe = "Class";
  static const rarity = "Rarity";
  static const height = "Height";
  static const preferredFoot = "Preferred Foot";
  static const position = "Position";
  static const attack = "Attack";
  static const defense = "Defense";
  static const creativity = "Creativity";
  static const tactic = "Tactic";
  static const technique = "Technique";
  static const preferredNumber = "Preferred Number";
}
