// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nflTeamMeta =
      const VerificationMeta('nflTeam');
  @override
  late final GeneratedColumn<String> nflTeam = GeneratedColumn<String>(
      'nfl_team', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _injuryRiskMeta =
      const VerificationMeta('injuryRisk');
  @override
  late final GeneratedColumn<double> injuryRisk = GeneratedColumn<double>(
      'injury_risk', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _crimeRiskMeta =
      const VerificationMeta('crimeRisk');
  @override
  late final GeneratedColumn<double> crimeRisk = GeneratedColumn<double>(
      'crime_risk', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _teamTalentScoreMeta =
      const VerificationMeta('teamTalentScore');
  @override
  late final GeneratedColumn<double> teamTalentScore = GeneratedColumn<double>(
      'team_talent_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _projPassYdsMeta =
      const VerificationMeta('projPassYds');
  @override
  late final GeneratedColumn<double> projPassYds = GeneratedColumn<double>(
      'proj_pass_yds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projPassTdsMeta =
      const VerificationMeta('projPassTds');
  @override
  late final GeneratedColumn<double> projPassTds = GeneratedColumn<double>(
      'proj_pass_tds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projRushYdsMeta =
      const VerificationMeta('projRushYds');
  @override
  late final GeneratedColumn<double> projRushYds = GeneratedColumn<double>(
      'proj_rush_yds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projRushTdsMeta =
      const VerificationMeta('projRushTds');
  @override
  late final GeneratedColumn<double> projRushTds = GeneratedColumn<double>(
      'proj_rush_tds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projRecMeta =
      const VerificationMeta('projRec');
  @override
  late final GeneratedColumn<double> projRec = GeneratedColumn<double>(
      'proj_rec', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projRecYdsMeta =
      const VerificationMeta('projRecYds');
  @override
  late final GeneratedColumn<double> projRecYds = GeneratedColumn<double>(
      'proj_rec_yds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projRecTdsMeta =
      const VerificationMeta('projRecTds');
  @override
  late final GeneratedColumn<double> projRecTds = GeneratedColumn<double>(
      'proj_rec_tds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _isDraftedMeta =
      const VerificationMeta('isDrafted');
  @override
  late final GeneratedColumn<bool> isDrafted = GeneratedColumn<bool>(
      'is_drafted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_drafted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        position,
        nflTeam,
        age,
        injuryRisk,
        crimeRisk,
        teamTalentScore,
        projPassYds,
        projPassTds,
        projRushYds,
        projRushTds,
        projRec,
        projRecYds,
        projRecTds,
        isDrafted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('nfl_team')) {
      context.handle(_nflTeamMeta,
          nflTeam.isAcceptableOrUnknown(data['nfl_team']!, _nflTeamMeta));
    } else if (isInserting) {
      context.missing(_nflTeamMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('injury_risk')) {
      context.handle(
          _injuryRiskMeta,
          injuryRisk.isAcceptableOrUnknown(
              data['injury_risk']!, _injuryRiskMeta));
    }
    if (data.containsKey('crime_risk')) {
      context.handle(_crimeRiskMeta,
          crimeRisk.isAcceptableOrUnknown(data['crime_risk']!, _crimeRiskMeta));
    }
    if (data.containsKey('team_talent_score')) {
      context.handle(
          _teamTalentScoreMeta,
          teamTalentScore.isAcceptableOrUnknown(
              data['team_talent_score']!, _teamTalentScoreMeta));
    }
    if (data.containsKey('proj_pass_yds')) {
      context.handle(
          _projPassYdsMeta,
          projPassYds.isAcceptableOrUnknown(
              data['proj_pass_yds']!, _projPassYdsMeta));
    }
    if (data.containsKey('proj_pass_tds')) {
      context.handle(
          _projPassTdsMeta,
          projPassTds.isAcceptableOrUnknown(
              data['proj_pass_tds']!, _projPassTdsMeta));
    }
    if (data.containsKey('proj_rush_yds')) {
      context.handle(
          _projRushYdsMeta,
          projRushYds.isAcceptableOrUnknown(
              data['proj_rush_yds']!, _projRushYdsMeta));
    }
    if (data.containsKey('proj_rush_tds')) {
      context.handle(
          _projRushTdsMeta,
          projRushTds.isAcceptableOrUnknown(
              data['proj_rush_tds']!, _projRushTdsMeta));
    }
    if (data.containsKey('proj_rec')) {
      context.handle(_projRecMeta,
          projRec.isAcceptableOrUnknown(data['proj_rec']!, _projRecMeta));
    }
    if (data.containsKey('proj_rec_yds')) {
      context.handle(
          _projRecYdsMeta,
          projRecYds.isAcceptableOrUnknown(
              data['proj_rec_yds']!, _projRecYdsMeta));
    }
    if (data.containsKey('proj_rec_tds')) {
      context.handle(
          _projRecTdsMeta,
          projRecTds.isAcceptableOrUnknown(
              data['proj_rec_tds']!, _projRecTdsMeta));
    }
    if (data.containsKey('is_drafted')) {
      context.handle(_isDraftedMeta,
          isDrafted.isAcceptableOrUnknown(data['is_drafted']!, _isDraftedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name, nflTeam},
      ];
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position'])!,
      nflTeam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nfl_team'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      injuryRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}injury_risk'])!,
      crimeRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}crime_risk'])!,
      teamTalentScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}team_talent_score'])!,
      projPassYds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pass_yds'])!,
      projPassTds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pass_tds'])!,
      projRushYds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_rush_yds'])!,
      projRushTds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_rush_tds'])!,
      projRec: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_rec'])!,
      projRecYds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_rec_yds'])!,
      projRecTds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_rec_tds'])!,
      isDrafted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_drafted'])!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final String position;
  final String nflTeam;
  final int age;
  final double injuryRisk;
  final double crimeRisk;
  final double teamTalentScore;
  final double projPassYds;
  final double projPassTds;
  final double projRushYds;
  final double projRushTds;
  final double projRec;
  final double projRecYds;
  final double projRecTds;
  final bool isDrafted;
  const Player(
      {required this.id,
      required this.name,
      required this.position,
      required this.nflTeam,
      required this.age,
      required this.injuryRisk,
      required this.crimeRisk,
      required this.teamTalentScore,
      required this.projPassYds,
      required this.projPassTds,
      required this.projRushYds,
      required this.projRushTds,
      required this.projRec,
      required this.projRecYds,
      required this.projRecTds,
      required this.isDrafted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['position'] = Variable<String>(position);
    map['nfl_team'] = Variable<String>(nflTeam);
    map['age'] = Variable<int>(age);
    map['injury_risk'] = Variable<double>(injuryRisk);
    map['crime_risk'] = Variable<double>(crimeRisk);
    map['team_talent_score'] = Variable<double>(teamTalentScore);
    map['proj_pass_yds'] = Variable<double>(projPassYds);
    map['proj_pass_tds'] = Variable<double>(projPassTds);
    map['proj_rush_yds'] = Variable<double>(projRushYds);
    map['proj_rush_tds'] = Variable<double>(projRushTds);
    map['proj_rec'] = Variable<double>(projRec);
    map['proj_rec_yds'] = Variable<double>(projRecYds);
    map['proj_rec_tds'] = Variable<double>(projRecTds);
    map['is_drafted'] = Variable<bool>(isDrafted);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      position: Value(position),
      nflTeam: Value(nflTeam),
      age: Value(age),
      injuryRisk: Value(injuryRisk),
      crimeRisk: Value(crimeRisk),
      teamTalentScore: Value(teamTalentScore),
      projPassYds: Value(projPassYds),
      projPassTds: Value(projPassTds),
      projRushYds: Value(projRushYds),
      projRushTds: Value(projRushTds),
      projRec: Value(projRec),
      projRecYds: Value(projRecYds),
      projRecTds: Value(projRecTds),
      isDrafted: Value(isDrafted),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      position: serializer.fromJson<String>(json['position']),
      nflTeam: serializer.fromJson<String>(json['nflTeam']),
      age: serializer.fromJson<int>(json['age']),
      injuryRisk: serializer.fromJson<double>(json['injuryRisk']),
      crimeRisk: serializer.fromJson<double>(json['crimeRisk']),
      teamTalentScore: serializer.fromJson<double>(json['teamTalentScore']),
      projPassYds: serializer.fromJson<double>(json['projPassYds']),
      projPassTds: serializer.fromJson<double>(json['projPassTds']),
      projRushYds: serializer.fromJson<double>(json['projRushYds']),
      projRushTds: serializer.fromJson<double>(json['projRushTds']),
      projRec: serializer.fromJson<double>(json['projRec']),
      projRecYds: serializer.fromJson<double>(json['projRecYds']),
      projRecTds: serializer.fromJson<double>(json['projRecTds']),
      isDrafted: serializer.fromJson<bool>(json['isDrafted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'position': serializer.toJson<String>(position),
      'nflTeam': serializer.toJson<String>(nflTeam),
      'age': serializer.toJson<int>(age),
      'injuryRisk': serializer.toJson<double>(injuryRisk),
      'crimeRisk': serializer.toJson<double>(crimeRisk),
      'teamTalentScore': serializer.toJson<double>(teamTalentScore),
      'projPassYds': serializer.toJson<double>(projPassYds),
      'projPassTds': serializer.toJson<double>(projPassTds),
      'projRushYds': serializer.toJson<double>(projRushYds),
      'projRushTds': serializer.toJson<double>(projRushTds),
      'projRec': serializer.toJson<double>(projRec),
      'projRecYds': serializer.toJson<double>(projRecYds),
      'projRecTds': serializer.toJson<double>(projRecTds),
      'isDrafted': serializer.toJson<bool>(isDrafted),
    };
  }

  Player copyWith(
          {int? id,
          String? name,
          String? position,
          String? nflTeam,
          int? age,
          double? injuryRisk,
          double? crimeRisk,
          double? teamTalentScore,
          double? projPassYds,
          double? projPassTds,
          double? projRushYds,
          double? projRushTds,
          double? projRec,
          double? projRecYds,
          double? projRecTds,
          bool? isDrafted}) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        position: position ?? this.position,
        nflTeam: nflTeam ?? this.nflTeam,
        age: age ?? this.age,
        injuryRisk: injuryRisk ?? this.injuryRisk,
        crimeRisk: crimeRisk ?? this.crimeRisk,
        teamTalentScore: teamTalentScore ?? this.teamTalentScore,
        projPassYds: projPassYds ?? this.projPassYds,
        projPassTds: projPassTds ?? this.projPassTds,
        projRushYds: projRushYds ?? this.projRushYds,
        projRushTds: projRushTds ?? this.projRushTds,
        projRec: projRec ?? this.projRec,
        projRecYds: projRecYds ?? this.projRecYds,
        projRecTds: projRecTds ?? this.projRecTds,
        isDrafted: isDrafted ?? this.isDrafted,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      nflTeam: data.nflTeam.present ? data.nflTeam.value : this.nflTeam,
      age: data.age.present ? data.age.value : this.age,
      injuryRisk:
          data.injuryRisk.present ? data.injuryRisk.value : this.injuryRisk,
      crimeRisk: data.crimeRisk.present ? data.crimeRisk.value : this.crimeRisk,
      teamTalentScore: data.teamTalentScore.present
          ? data.teamTalentScore.value
          : this.teamTalentScore,
      projPassYds:
          data.projPassYds.present ? data.projPassYds.value : this.projPassYds,
      projPassTds:
          data.projPassTds.present ? data.projPassTds.value : this.projPassTds,
      projRushYds:
          data.projRushYds.present ? data.projRushYds.value : this.projRushYds,
      projRushTds:
          data.projRushTds.present ? data.projRushTds.value : this.projRushTds,
      projRec: data.projRec.present ? data.projRec.value : this.projRec,
      projRecYds:
          data.projRecYds.present ? data.projRecYds.value : this.projRecYds,
      projRecTds:
          data.projRecTds.present ? data.projRecTds.value : this.projRecTds,
      isDrafted: data.isDrafted.present ? data.isDrafted.value : this.isDrafted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('nflTeam: $nflTeam, ')
          ..write('age: $age, ')
          ..write('injuryRisk: $injuryRisk, ')
          ..write('crimeRisk: $crimeRisk, ')
          ..write('teamTalentScore: $teamTalentScore, ')
          ..write('projPassYds: $projPassYds, ')
          ..write('projPassTds: $projPassTds, ')
          ..write('projRushYds: $projRushYds, ')
          ..write('projRushTds: $projRushTds, ')
          ..write('projRec: $projRec, ')
          ..write('projRecYds: $projRecYds, ')
          ..write('projRecTds: $projRecTds, ')
          ..write('isDrafted: $isDrafted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      position,
      nflTeam,
      age,
      injuryRisk,
      crimeRisk,
      teamTalentScore,
      projPassYds,
      projPassTds,
      projRushYds,
      projRushTds,
      projRec,
      projRecYds,
      projRecTds,
      isDrafted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.position == this.position &&
          other.nflTeam == this.nflTeam &&
          other.age == this.age &&
          other.injuryRisk == this.injuryRisk &&
          other.crimeRisk == this.crimeRisk &&
          other.teamTalentScore == this.teamTalentScore &&
          other.projPassYds == this.projPassYds &&
          other.projPassTds == this.projPassTds &&
          other.projRushYds == this.projRushYds &&
          other.projRushTds == this.projRushTds &&
          other.projRec == this.projRec &&
          other.projRecYds == this.projRecYds &&
          other.projRecTds == this.projRecTds &&
          other.isDrafted == this.isDrafted);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> position;
  final Value<String> nflTeam;
  final Value<int> age;
  final Value<double> injuryRisk;
  final Value<double> crimeRisk;
  final Value<double> teamTalentScore;
  final Value<double> projPassYds;
  final Value<double> projPassTds;
  final Value<double> projRushYds;
  final Value<double> projRushTds;
  final Value<double> projRec;
  final Value<double> projRecYds;
  final Value<double> projRecTds;
  final Value<bool> isDrafted;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.nflTeam = const Value.absent(),
    this.age = const Value.absent(),
    this.injuryRisk = const Value.absent(),
    this.crimeRisk = const Value.absent(),
    this.teamTalentScore = const Value.absent(),
    this.projPassYds = const Value.absent(),
    this.projPassTds = const Value.absent(),
    this.projRushYds = const Value.absent(),
    this.projRushTds = const Value.absent(),
    this.projRec = const Value.absent(),
    this.projRecYds = const Value.absent(),
    this.projRecTds = const Value.absent(),
    this.isDrafted = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String position,
    required String nflTeam,
    required int age,
    this.injuryRisk = const Value.absent(),
    this.crimeRisk = const Value.absent(),
    this.teamTalentScore = const Value.absent(),
    this.projPassYds = const Value.absent(),
    this.projPassTds = const Value.absent(),
    this.projRushYds = const Value.absent(),
    this.projRushTds = const Value.absent(),
    this.projRec = const Value.absent(),
    this.projRecYds = const Value.absent(),
    this.projRecTds = const Value.absent(),
    this.isDrafted = const Value.absent(),
  })  : name = Value(name),
        position = Value(position),
        nflTeam = Value(nflTeam),
        age = Value(age);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? position,
    Expression<String>? nflTeam,
    Expression<int>? age,
    Expression<double>? injuryRisk,
    Expression<double>? crimeRisk,
    Expression<double>? teamTalentScore,
    Expression<double>? projPassYds,
    Expression<double>? projPassTds,
    Expression<double>? projRushYds,
    Expression<double>? projRushTds,
    Expression<double>? projRec,
    Expression<double>? projRecYds,
    Expression<double>? projRecTds,
    Expression<bool>? isDrafted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (nflTeam != null) 'nfl_team': nflTeam,
      if (age != null) 'age': age,
      if (injuryRisk != null) 'injury_risk': injuryRisk,
      if (crimeRisk != null) 'crime_risk': crimeRisk,
      if (teamTalentScore != null) 'team_talent_score': teamTalentScore,
      if (projPassYds != null) 'proj_pass_yds': projPassYds,
      if (projPassTds != null) 'proj_pass_tds': projPassTds,
      if (projRushYds != null) 'proj_rush_yds': projRushYds,
      if (projRushTds != null) 'proj_rush_tds': projRushTds,
      if (projRec != null) 'proj_rec': projRec,
      if (projRecYds != null) 'proj_rec_yds': projRecYds,
      if (projRecTds != null) 'proj_rec_tds': projRecTds,
      if (isDrafted != null) 'is_drafted': isDrafted,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? position,
      Value<String>? nflTeam,
      Value<int>? age,
      Value<double>? injuryRisk,
      Value<double>? crimeRisk,
      Value<double>? teamTalentScore,
      Value<double>? projPassYds,
      Value<double>? projPassTds,
      Value<double>? projRushYds,
      Value<double>? projRushTds,
      Value<double>? projRec,
      Value<double>? projRecYds,
      Value<double>? projRecTds,
      Value<bool>? isDrafted}) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      nflTeam: nflTeam ?? this.nflTeam,
      age: age ?? this.age,
      injuryRisk: injuryRisk ?? this.injuryRisk,
      crimeRisk: crimeRisk ?? this.crimeRisk,
      teamTalentScore: teamTalentScore ?? this.teamTalentScore,
      projPassYds: projPassYds ?? this.projPassYds,
      projPassTds: projPassTds ?? this.projPassTds,
      projRushYds: projRushYds ?? this.projRushYds,
      projRushTds: projRushTds ?? this.projRushTds,
      projRec: projRec ?? this.projRec,
      projRecYds: projRecYds ?? this.projRecYds,
      projRecTds: projRecTds ?? this.projRecTds,
      isDrafted: isDrafted ?? this.isDrafted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (nflTeam.present) {
      map['nfl_team'] = Variable<String>(nflTeam.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (injuryRisk.present) {
      map['injury_risk'] = Variable<double>(injuryRisk.value);
    }
    if (crimeRisk.present) {
      map['crime_risk'] = Variable<double>(crimeRisk.value);
    }
    if (teamTalentScore.present) {
      map['team_talent_score'] = Variable<double>(teamTalentScore.value);
    }
    if (projPassYds.present) {
      map['proj_pass_yds'] = Variable<double>(projPassYds.value);
    }
    if (projPassTds.present) {
      map['proj_pass_tds'] = Variable<double>(projPassTds.value);
    }
    if (projRushYds.present) {
      map['proj_rush_yds'] = Variable<double>(projRushYds.value);
    }
    if (projRushTds.present) {
      map['proj_rush_tds'] = Variable<double>(projRushTds.value);
    }
    if (projRec.present) {
      map['proj_rec'] = Variable<double>(projRec.value);
    }
    if (projRecYds.present) {
      map['proj_rec_yds'] = Variable<double>(projRecYds.value);
    }
    if (projRecTds.present) {
      map['proj_rec_tds'] = Variable<double>(projRecTds.value);
    }
    if (isDrafted.present) {
      map['is_drafted'] = Variable<bool>(isDrafted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('nflTeam: $nflTeam, ')
          ..write('age: $age, ')
          ..write('injuryRisk: $injuryRisk, ')
          ..write('crimeRisk: $crimeRisk, ')
          ..write('teamTalentScore: $teamTalentScore, ')
          ..write('projPassYds: $projPassYds, ')
          ..write('projPassTds: $projPassTds, ')
          ..write('projRushYds: $projRushYds, ')
          ..write('projRushTds: $projRushTds, ')
          ..write('projRec: $projRec, ')
          ..write('projRecYds: $projRecYds, ')
          ..write('projRecTds: $projRecTds, ')
          ..write('isDrafted: $isDrafted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [players];
}

typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  required String name,
  required String position,
  required String nflTeam,
  required int age,
  Value<double> injuryRisk,
  Value<double> crimeRisk,
  Value<double> teamTalentScore,
  Value<double> projPassYds,
  Value<double> projPassTds,
  Value<double> projRushYds,
  Value<double> projRushTds,
  Value<double> projRec,
  Value<double> projRecYds,
  Value<double> projRecTds,
  Value<bool> isDrafted,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> position,
  Value<String> nflTeam,
  Value<int> age,
  Value<double> injuryRisk,
  Value<double> crimeRisk,
  Value<double> teamTalentScore,
  Value<double> projPassYds,
  Value<double> projPassTds,
  Value<double> projRushYds,
  Value<double> projRushTds,
  Value<double> projRec,
  Value<double> projRecYds,
  Value<double> projRecTds,
  Value<bool> isDrafted,
});

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nflTeam => $composableBuilder(
      column: $table.nflTeam, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get crimeRisk => $composableBuilder(
      column: $table.crimeRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projRushYds => $composableBuilder(
      column: $table.projRushYds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projRushTds => $composableBuilder(
      column: $table.projRushTds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projRec => $composableBuilder(
      column: $table.projRec, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projRecYds => $composableBuilder(
      column: $table.projRecYds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projRecTds => $composableBuilder(
      column: $table.projRecTds, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDrafted => $composableBuilder(
      column: $table.isDrafted, builder: (column) => ColumnFilters(column));
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nflTeam => $composableBuilder(
      column: $table.nflTeam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get crimeRisk => $composableBuilder(
      column: $table.crimeRisk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projRushYds => $composableBuilder(
      column: $table.projRushYds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projRushTds => $composableBuilder(
      column: $table.projRushTds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projRec => $composableBuilder(
      column: $table.projRec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projRecYds => $composableBuilder(
      column: $table.projRecYds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projRecTds => $composableBuilder(
      column: $table.projRecTds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDrafted => $composableBuilder(
      column: $table.isDrafted, builder: (column) => ColumnOrderings(column));
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get nflTeam =>
      $composableBuilder(column: $table.nflTeam, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => column);

  GeneratedColumn<double> get crimeRisk =>
      $composableBuilder(column: $table.crimeRisk, builder: (column) => column);

  GeneratedColumn<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore, builder: (column) => column);

  GeneratedColumn<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => column);

  GeneratedColumn<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => column);

  GeneratedColumn<double> get projRushYds => $composableBuilder(
      column: $table.projRushYds, builder: (column) => column);

  GeneratedColumn<double> get projRushTds => $composableBuilder(
      column: $table.projRushTds, builder: (column) => column);

  GeneratedColumn<double> get projRec =>
      $composableBuilder(column: $table.projRec, builder: (column) => column);

  GeneratedColumn<double> get projRecYds => $composableBuilder(
      column: $table.projRecYds, builder: (column) => column);

  GeneratedColumn<double> get projRecTds => $composableBuilder(
      column: $table.projRecTds, builder: (column) => column);

  GeneratedColumn<bool> get isDrafted =>
      $composableBuilder(column: $table.isDrafted, builder: (column) => column);
}

class $$PlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()> {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> position = const Value.absent(),
            Value<String> nflTeam = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<double> injuryRisk = const Value.absent(),
            Value<double> crimeRisk = const Value.absent(),
            Value<double> teamTalentScore = const Value.absent(),
            Value<double> projPassYds = const Value.absent(),
            Value<double> projPassTds = const Value.absent(),
            Value<double> projRushYds = const Value.absent(),
            Value<double> projRushTds = const Value.absent(),
            Value<double> projRec = const Value.absent(),
            Value<double> projRecYds = const Value.absent(),
            Value<double> projRecTds = const Value.absent(),
            Value<bool> isDrafted = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            name: name,
            position: position,
            nflTeam: nflTeam,
            age: age,
            injuryRisk: injuryRisk,
            crimeRisk: crimeRisk,
            teamTalentScore: teamTalentScore,
            projPassYds: projPassYds,
            projPassTds: projPassTds,
            projRushYds: projRushYds,
            projRushTds: projRushTds,
            projRec: projRec,
            projRecYds: projRecYds,
            projRecTds: projRecTds,
            isDrafted: isDrafted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String position,
            required String nflTeam,
            required int age,
            Value<double> injuryRisk = const Value.absent(),
            Value<double> crimeRisk = const Value.absent(),
            Value<double> teamTalentScore = const Value.absent(),
            Value<double> projPassYds = const Value.absent(),
            Value<double> projPassTds = const Value.absent(),
            Value<double> projRushYds = const Value.absent(),
            Value<double> projRushTds = const Value.absent(),
            Value<double> projRec = const Value.absent(),
            Value<double> projRecYds = const Value.absent(),
            Value<double> projRecTds = const Value.absent(),
            Value<bool> isDrafted = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            name: name,
            position: position,
            nflTeam: nflTeam,
            age: age,
            injuryRisk: injuryRisk,
            crimeRisk: crimeRisk,
            teamTalentScore: teamTalentScore,
            projPassYds: projPassYds,
            projPassTds: projPassTds,
            projRushYds: projRushYds,
            projRushTds: projRushTds,
            projRec: projRec,
            projRecYds: projRecYds,
            projRecTds: projRecTds,
            isDrafted: isDrafted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
}
