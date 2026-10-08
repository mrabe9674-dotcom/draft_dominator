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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nflTeamMeta =
      const VerificationMeta('nflTeam');
  @override
  late final GeneratedColumn<String> nflTeam = GeneratedColumn<String>(
      'nfl_team', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  static const VerificationMeta _adpMeta = const VerificationMeta('adp');
  @override
  late final GeneratedColumn<double> adp = GeneratedColumn<double>(
      'adp', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(999.0));
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
  static const VerificationMeta _projPassIntsMeta =
      const VerificationMeta('projPassInts');
  @override
  late final GeneratedColumn<double> projPassInts = GeneratedColumn<double>(
      'proj_pass_ints', aliasedName, false,
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
  static const VerificationMeta _projFgMadeMeta =
      const VerificationMeta('projFgMade');
  @override
  late final GeneratedColumn<double> projFgMade = GeneratedColumn<double>(
      'proj_fg_made', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projFg50PlusMeta =
      const VerificationMeta('projFg50Plus');
  @override
  late final GeneratedColumn<double> projFg50Plus = GeneratedColumn<double>(
      'proj_fg50_plus', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projPatMadeMeta =
      const VerificationMeta('projPatMade');
  @override
  late final GeneratedColumn<double> projPatMade = GeneratedColumn<double>(
      'proj_pat_made', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projSacksMeta =
      const VerificationMeta('projSacks');
  @override
  late final GeneratedColumn<double> projSacks = GeneratedColumn<double>(
      'proj_sacks', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projTakeawaysMeta =
      const VerificationMeta('projTakeaways');
  @override
  late final GeneratedColumn<double> projTakeaways = GeneratedColumn<double>(
      'proj_takeaways', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projDefTdsMeta =
      const VerificationMeta('projDefTds');
  @override
  late final GeneratedColumn<double> projDefTds = GeneratedColumn<double>(
      'proj_def_tds', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _projPtsAllowedBaselineMeta =
      const VerificationMeta('projPtsAllowedBaseline');
  @override
  late final GeneratedColumn<double> projPtsAllowedBaseline =
      GeneratedColumn<double>('proj_pts_allowed_baseline', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _priorYearPtsMeta =
      const VerificationMeta('priorYearPts');
  @override
  late final GeneratedColumn<double> priorYearPts = GeneratedColumn<double>(
      'prior_year_pts', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _priorYearSummaryMeta =
      const VerificationMeta('priorYearSummary');
  @override
  late final GeneratedColumn<String> priorYearSummary = GeneratedColumn<String>(
      'prior_year_summary', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        position,
        nflTeam,
        age,
        isDrafted,
        injuryRisk,
        crimeRisk,
        teamTalentScore,
        adp,
        projPassYds,
        projPassTds,
        projPassInts,
        projRushYds,
        projRushTds,
        projRec,
        projRecYds,
        projRecTds,
        projFgMade,
        projFg50Plus,
        projPatMade,
        projSacks,
        projTakeaways,
        projDefTds,
        projPtsAllowedBaseline,
        priorYearPts,
        priorYearSummary
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
    if (data.containsKey('is_drafted')) {
      context.handle(_isDraftedMeta,
          isDrafted.isAcceptableOrUnknown(data['is_drafted']!, _isDraftedMeta));
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
    if (data.containsKey('adp')) {
      context.handle(
          _adpMeta, adp.isAcceptableOrUnknown(data['adp']!, _adpMeta));
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
    if (data.containsKey('proj_pass_ints')) {
      context.handle(
          _projPassIntsMeta,
          projPassInts.isAcceptableOrUnknown(
              data['proj_pass_ints']!, _projPassIntsMeta));
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
    if (data.containsKey('proj_fg_made')) {
      context.handle(
          _projFgMadeMeta,
          projFgMade.isAcceptableOrUnknown(
              data['proj_fg_made']!, _projFgMadeMeta));
    }
    if (data.containsKey('proj_fg50_plus')) {
      context.handle(
          _projFg50PlusMeta,
          projFg50Plus.isAcceptableOrUnknown(
              data['proj_fg50_plus']!, _projFg50PlusMeta));
    }
    if (data.containsKey('proj_pat_made')) {
      context.handle(
          _projPatMadeMeta,
          projPatMade.isAcceptableOrUnknown(
              data['proj_pat_made']!, _projPatMadeMeta));
    }
    if (data.containsKey('proj_sacks')) {
      context.handle(_projSacksMeta,
          projSacks.isAcceptableOrUnknown(data['proj_sacks']!, _projSacksMeta));
    }
    if (data.containsKey('proj_takeaways')) {
      context.handle(
          _projTakeawaysMeta,
          projTakeaways.isAcceptableOrUnknown(
              data['proj_takeaways']!, _projTakeawaysMeta));
    }
    if (data.containsKey('proj_def_tds')) {
      context.handle(
          _projDefTdsMeta,
          projDefTds.isAcceptableOrUnknown(
              data['proj_def_tds']!, _projDefTdsMeta));
    }
    if (data.containsKey('proj_pts_allowed_baseline')) {
      context.handle(
          _projPtsAllowedBaselineMeta,
          projPtsAllowedBaseline.isAcceptableOrUnknown(
              data['proj_pts_allowed_baseline']!, _projPtsAllowedBaselineMeta));
    }
    if (data.containsKey('prior_year_pts')) {
      context.handle(
          _priorYearPtsMeta,
          priorYearPts.isAcceptableOrUnknown(
              data['prior_year_pts']!, _priorYearPtsMeta));
    }
    if (data.containsKey('prior_year_summary')) {
      context.handle(
          _priorYearSummaryMeta,
          priorYearSummary.isAcceptableOrUnknown(
              data['prior_year_summary']!, _priorYearSummaryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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
      isDrafted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_drafted'])!,
      injuryRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}injury_risk'])!,
      crimeRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}crime_risk'])!,
      teamTalentScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}team_talent_score'])!,
      adp: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}adp'])!,
      projPassYds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pass_yds'])!,
      projPassTds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pass_tds'])!,
      projPassInts: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pass_ints'])!,
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
      projFgMade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_fg_made'])!,
      projFg50Plus: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_fg50_plus'])!,
      projPatMade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_pat_made'])!,
      projSacks: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_sacks'])!,
      projTakeaways: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_takeaways'])!,
      projDefTds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proj_def_tds'])!,
      projPtsAllowedBaseline: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}proj_pts_allowed_baseline'])!,
      priorYearPts: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}prior_year_pts'])!,
      priorYearSummary: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prior_year_summary'])!,
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
  final bool isDrafted;
  final double injuryRisk;
  final double crimeRisk;
  final double teamTalentScore;
  final double adp;
  final double projPassYds;
  final double projPassTds;
  final double projPassInts;
  final double projRushYds;
  final double projRushTds;
  final double projRec;
  final double projRecYds;
  final double projRecTds;
  final double projFgMade;
  final double projFg50Plus;
  final double projPatMade;
  final double projSacks;
  final double projTakeaways;
  final double projDefTds;
  final double projPtsAllowedBaseline;
  final double priorYearPts;
  final String priorYearSummary;
  const Player(
      {required this.id,
      required this.name,
      required this.position,
      required this.nflTeam,
      required this.age,
      required this.isDrafted,
      required this.injuryRisk,
      required this.crimeRisk,
      required this.teamTalentScore,
      required this.adp,
      required this.projPassYds,
      required this.projPassTds,
      required this.projPassInts,
      required this.projRushYds,
      required this.projRushTds,
      required this.projRec,
      required this.projRecYds,
      required this.projRecTds,
      required this.projFgMade,
      required this.projFg50Plus,
      required this.projPatMade,
      required this.projSacks,
      required this.projTakeaways,
      required this.projDefTds,
      required this.projPtsAllowedBaseline,
      required this.priorYearPts,
      required this.priorYearSummary});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['position'] = Variable<String>(position);
    map['nfl_team'] = Variable<String>(nflTeam);
    map['age'] = Variable<int>(age);
    map['is_drafted'] = Variable<bool>(isDrafted);
    map['injury_risk'] = Variable<double>(injuryRisk);
    map['crime_risk'] = Variable<double>(crimeRisk);
    map['team_talent_score'] = Variable<double>(teamTalentScore);
    map['adp'] = Variable<double>(adp);
    map['proj_pass_yds'] = Variable<double>(projPassYds);
    map['proj_pass_tds'] = Variable<double>(projPassTds);
    map['proj_pass_ints'] = Variable<double>(projPassInts);
    map['proj_rush_yds'] = Variable<double>(projRushYds);
    map['proj_rush_tds'] = Variable<double>(projRushTds);
    map['proj_rec'] = Variable<double>(projRec);
    map['proj_rec_yds'] = Variable<double>(projRecYds);
    map['proj_rec_tds'] = Variable<double>(projRecTds);
    map['proj_fg_made'] = Variable<double>(projFgMade);
    map['proj_fg50_plus'] = Variable<double>(projFg50Plus);
    map['proj_pat_made'] = Variable<double>(projPatMade);
    map['proj_sacks'] = Variable<double>(projSacks);
    map['proj_takeaways'] = Variable<double>(projTakeaways);
    map['proj_def_tds'] = Variable<double>(projDefTds);
    map['proj_pts_allowed_baseline'] = Variable<double>(projPtsAllowedBaseline);
    map['prior_year_pts'] = Variable<double>(priorYearPts);
    map['prior_year_summary'] = Variable<String>(priorYearSummary);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      position: Value(position),
      nflTeam: Value(nflTeam),
      age: Value(age),
      isDrafted: Value(isDrafted),
      injuryRisk: Value(injuryRisk),
      crimeRisk: Value(crimeRisk),
      teamTalentScore: Value(teamTalentScore),
      adp: Value(adp),
      projPassYds: Value(projPassYds),
      projPassTds: Value(projPassTds),
      projPassInts: Value(projPassInts),
      projRushYds: Value(projRushYds),
      projRushTds: Value(projRushTds),
      projRec: Value(projRec),
      projRecYds: Value(projRecYds),
      projRecTds: Value(projRecTds),
      projFgMade: Value(projFgMade),
      projFg50Plus: Value(projFg50Plus),
      projPatMade: Value(projPatMade),
      projSacks: Value(projSacks),
      projTakeaways: Value(projTakeaways),
      projDefTds: Value(projDefTds),
      projPtsAllowedBaseline: Value(projPtsAllowedBaseline),
      priorYearPts: Value(priorYearPts),
      priorYearSummary: Value(priorYearSummary),
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
      isDrafted: serializer.fromJson<bool>(json['isDrafted']),
      injuryRisk: serializer.fromJson<double>(json['injuryRisk']),
      crimeRisk: serializer.fromJson<double>(json['crimeRisk']),
      teamTalentScore: serializer.fromJson<double>(json['teamTalentScore']),
      adp: serializer.fromJson<double>(json['adp']),
      projPassYds: serializer.fromJson<double>(json['projPassYds']),
      projPassTds: serializer.fromJson<double>(json['projPassTds']),
      projPassInts: serializer.fromJson<double>(json['projPassInts']),
      projRushYds: serializer.fromJson<double>(json['projRushYds']),
      projRushTds: serializer.fromJson<double>(json['projRushTds']),
      projRec: serializer.fromJson<double>(json['projRec']),
      projRecYds: serializer.fromJson<double>(json['projRecYds']),
      projRecTds: serializer.fromJson<double>(json['projRecTds']),
      projFgMade: serializer.fromJson<double>(json['projFgMade']),
      projFg50Plus: serializer.fromJson<double>(json['projFg50Plus']),
      projPatMade: serializer.fromJson<double>(json['projPatMade']),
      projSacks: serializer.fromJson<double>(json['projSacks']),
      projTakeaways: serializer.fromJson<double>(json['projTakeaways']),
      projDefTds: serializer.fromJson<double>(json['projDefTds']),
      projPtsAllowedBaseline:
          serializer.fromJson<double>(json['projPtsAllowedBaseline']),
      priorYearPts: serializer.fromJson<double>(json['priorYearPts']),
      priorYearSummary: serializer.fromJson<String>(json['priorYearSummary']),
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
      'isDrafted': serializer.toJson<bool>(isDrafted),
      'injuryRisk': serializer.toJson<double>(injuryRisk),
      'crimeRisk': serializer.toJson<double>(crimeRisk),
      'teamTalentScore': serializer.toJson<double>(teamTalentScore),
      'adp': serializer.toJson<double>(adp),
      'projPassYds': serializer.toJson<double>(projPassYds),
      'projPassTds': serializer.toJson<double>(projPassTds),
      'projPassInts': serializer.toJson<double>(projPassInts),
      'projRushYds': serializer.toJson<double>(projRushYds),
      'projRushTds': serializer.toJson<double>(projRushTds),
      'projRec': serializer.toJson<double>(projRec),
      'projRecYds': serializer.toJson<double>(projRecYds),
      'projRecTds': serializer.toJson<double>(projRecTds),
      'projFgMade': serializer.toJson<double>(projFgMade),
      'projFg50Plus': serializer.toJson<double>(projFg50Plus),
      'projPatMade': serializer.toJson<double>(projPatMade),
      'projSacks': serializer.toJson<double>(projSacks),
      'projTakeaways': serializer.toJson<double>(projTakeaways),
      'projDefTds': serializer.toJson<double>(projDefTds),
      'projPtsAllowedBaseline':
          serializer.toJson<double>(projPtsAllowedBaseline),
      'priorYearPts': serializer.toJson<double>(priorYearPts),
      'priorYearSummary': serializer.toJson<String>(priorYearSummary),
    };
  }

  Player copyWith(
          {int? id,
          String? name,
          String? position,
          String? nflTeam,
          int? age,
          bool? isDrafted,
          double? injuryRisk,
          double? crimeRisk,
          double? teamTalentScore,
          double? adp,
          double? projPassYds,
          double? projPassTds,
          double? projPassInts,
          double? projRushYds,
          double? projRushTds,
          double? projRec,
          double? projRecYds,
          double? projRecTds,
          double? projFgMade,
          double? projFg50Plus,
          double? projPatMade,
          double? projSacks,
          double? projTakeaways,
          double? projDefTds,
          double? projPtsAllowedBaseline,
          double? priorYearPts,
          String? priorYearSummary}) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        position: position ?? this.position,
        nflTeam: nflTeam ?? this.nflTeam,
        age: age ?? this.age,
        isDrafted: isDrafted ?? this.isDrafted,
        injuryRisk: injuryRisk ?? this.injuryRisk,
        crimeRisk: crimeRisk ?? this.crimeRisk,
        teamTalentScore: teamTalentScore ?? this.teamTalentScore,
        adp: adp ?? this.adp,
        projPassYds: projPassYds ?? this.projPassYds,
        projPassTds: projPassTds ?? this.projPassTds,
        projPassInts: projPassInts ?? this.projPassInts,
        projRushYds: projRushYds ?? this.projRushYds,
        projRushTds: projRushTds ?? this.projRushTds,
        projRec: projRec ?? this.projRec,
        projRecYds: projRecYds ?? this.projRecYds,
        projRecTds: projRecTds ?? this.projRecTds,
        projFgMade: projFgMade ?? this.projFgMade,
        projFg50Plus: projFg50Plus ?? this.projFg50Plus,
        projPatMade: projPatMade ?? this.projPatMade,
        projSacks: projSacks ?? this.projSacks,
        projTakeaways: projTakeaways ?? this.projTakeaways,
        projDefTds: projDefTds ?? this.projDefTds,
        projPtsAllowedBaseline:
            projPtsAllowedBaseline ?? this.projPtsAllowedBaseline,
        priorYearPts: priorYearPts ?? this.priorYearPts,
        priorYearSummary: priorYearSummary ?? this.priorYearSummary,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      nflTeam: data.nflTeam.present ? data.nflTeam.value : this.nflTeam,
      age: data.age.present ? data.age.value : this.age,
      isDrafted: data.isDrafted.present ? data.isDrafted.value : this.isDrafted,
      injuryRisk:
          data.injuryRisk.present ? data.injuryRisk.value : this.injuryRisk,
      crimeRisk: data.crimeRisk.present ? data.crimeRisk.value : this.crimeRisk,
      teamTalentScore: data.teamTalentScore.present
          ? data.teamTalentScore.value
          : this.teamTalentScore,
      adp: data.adp.present ? data.adp.value : this.adp,
      projPassYds:
          data.projPassYds.present ? data.projPassYds.value : this.projPassYds,
      projPassTds:
          data.projPassTds.present ? data.projPassTds.value : this.projPassTds,
      projPassInts: data.projPassInts.present
          ? data.projPassInts.value
          : this.projPassInts,
      projRushYds:
          data.projRushYds.present ? data.projRushYds.value : this.projRushYds,
      projRushTds:
          data.projRushTds.present ? data.projRushTds.value : this.projRushTds,
      projRec: data.projRec.present ? data.projRec.value : this.projRec,
      projRecYds:
          data.projRecYds.present ? data.projRecYds.value : this.projRecYds,
      projRecTds:
          data.projRecTds.present ? data.projRecTds.value : this.projRecTds,
      projFgMade:
          data.projFgMade.present ? data.projFgMade.value : this.projFgMade,
      projFg50Plus: data.projFg50Plus.present
          ? data.projFg50Plus.value
          : this.projFg50Plus,
      projPatMade:
          data.projPatMade.present ? data.projPatMade.value : this.projPatMade,
      projSacks: data.projSacks.present ? data.projSacks.value : this.projSacks,
      projTakeaways: data.projTakeaways.present
          ? data.projTakeaways.value
          : this.projTakeaways,
      projDefTds:
          data.projDefTds.present ? data.projDefTds.value : this.projDefTds,
      projPtsAllowedBaseline: data.projPtsAllowedBaseline.present
          ? data.projPtsAllowedBaseline.value
          : this.projPtsAllowedBaseline,
      priorYearPts: data.priorYearPts.present
          ? data.priorYearPts.value
          : this.priorYearPts,
      priorYearSummary: data.priorYearSummary.present
          ? data.priorYearSummary.value
          : this.priorYearSummary,
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
          ..write('isDrafted: $isDrafted, ')
          ..write('injuryRisk: $injuryRisk, ')
          ..write('crimeRisk: $crimeRisk, ')
          ..write('teamTalentScore: $teamTalentScore, ')
          ..write('adp: $adp, ')
          ..write('projPassYds: $projPassYds, ')
          ..write('projPassTds: $projPassTds, ')
          ..write('projPassInts: $projPassInts, ')
          ..write('projRushYds: $projRushYds, ')
          ..write('projRushTds: $projRushTds, ')
          ..write('projRec: $projRec, ')
          ..write('projRecYds: $projRecYds, ')
          ..write('projRecTds: $projRecTds, ')
          ..write('projFgMade: $projFgMade, ')
          ..write('projFg50Plus: $projFg50Plus, ')
          ..write('projPatMade: $projPatMade, ')
          ..write('projSacks: $projSacks, ')
          ..write('projTakeaways: $projTakeaways, ')
          ..write('projDefTds: $projDefTds, ')
          ..write('projPtsAllowedBaseline: $projPtsAllowedBaseline, ')
          ..write('priorYearPts: $priorYearPts, ')
          ..write('priorYearSummary: $priorYearSummary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        position,
        nflTeam,
        age,
        isDrafted,
        injuryRisk,
        crimeRisk,
        teamTalentScore,
        adp,
        projPassYds,
        projPassTds,
        projPassInts,
        projRushYds,
        projRushTds,
        projRec,
        projRecYds,
        projRecTds,
        projFgMade,
        projFg50Plus,
        projPatMade,
        projSacks,
        projTakeaways,
        projDefTds,
        projPtsAllowedBaseline,
        priorYearPts,
        priorYearSummary
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.position == this.position &&
          other.nflTeam == this.nflTeam &&
          other.age == this.age &&
          other.isDrafted == this.isDrafted &&
          other.injuryRisk == this.injuryRisk &&
          other.crimeRisk == this.crimeRisk &&
          other.teamTalentScore == this.teamTalentScore &&
          other.adp == this.adp &&
          other.projPassYds == this.projPassYds &&
          other.projPassTds == this.projPassTds &&
          other.projPassInts == this.projPassInts &&
          other.projRushYds == this.projRushYds &&
          other.projRushTds == this.projRushTds &&
          other.projRec == this.projRec &&
          other.projRecYds == this.projRecYds &&
          other.projRecTds == this.projRecTds &&
          other.projFgMade == this.projFgMade &&
          other.projFg50Plus == this.projFg50Plus &&
          other.projPatMade == this.projPatMade &&
          other.projSacks == this.projSacks &&
          other.projTakeaways == this.projTakeaways &&
          other.projDefTds == this.projDefTds &&
          other.projPtsAllowedBaseline == this.projPtsAllowedBaseline &&
          other.priorYearPts == this.priorYearPts &&
          other.priorYearSummary == this.priorYearSummary);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> position;
  final Value<String> nflTeam;
  final Value<int> age;
  final Value<bool> isDrafted;
  final Value<double> injuryRisk;
  final Value<double> crimeRisk;
  final Value<double> teamTalentScore;
  final Value<double> adp;
  final Value<double> projPassYds;
  final Value<double> projPassTds;
  final Value<double> projPassInts;
  final Value<double> projRushYds;
  final Value<double> projRushTds;
  final Value<double> projRec;
  final Value<double> projRecYds;
  final Value<double> projRecTds;
  final Value<double> projFgMade;
  final Value<double> projFg50Plus;
  final Value<double> projPatMade;
  final Value<double> projSacks;
  final Value<double> projTakeaways;
  final Value<double> projDefTds;
  final Value<double> projPtsAllowedBaseline;
  final Value<double> priorYearPts;
  final Value<String> priorYearSummary;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.nflTeam = const Value.absent(),
    this.age = const Value.absent(),
    this.isDrafted = const Value.absent(),
    this.injuryRisk = const Value.absent(),
    this.crimeRisk = const Value.absent(),
    this.teamTalentScore = const Value.absent(),
    this.adp = const Value.absent(),
    this.projPassYds = const Value.absent(),
    this.projPassTds = const Value.absent(),
    this.projPassInts = const Value.absent(),
    this.projRushYds = const Value.absent(),
    this.projRushTds = const Value.absent(),
    this.projRec = const Value.absent(),
    this.projRecYds = const Value.absent(),
    this.projRecTds = const Value.absent(),
    this.projFgMade = const Value.absent(),
    this.projFg50Plus = const Value.absent(),
    this.projPatMade = const Value.absent(),
    this.projSacks = const Value.absent(),
    this.projTakeaways = const Value.absent(),
    this.projDefTds = const Value.absent(),
    this.projPtsAllowedBaseline = const Value.absent(),
    this.priorYearPts = const Value.absent(),
    this.priorYearSummary = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String position,
    required String nflTeam,
    required int age,
    this.isDrafted = const Value.absent(),
    this.injuryRisk = const Value.absent(),
    this.crimeRisk = const Value.absent(),
    this.teamTalentScore = const Value.absent(),
    this.adp = const Value.absent(),
    this.projPassYds = const Value.absent(),
    this.projPassTds = const Value.absent(),
    this.projPassInts = const Value.absent(),
    this.projRushYds = const Value.absent(),
    this.projRushTds = const Value.absent(),
    this.projRec = const Value.absent(),
    this.projRecYds = const Value.absent(),
    this.projRecTds = const Value.absent(),
    this.projFgMade = const Value.absent(),
    this.projFg50Plus = const Value.absent(),
    this.projPatMade = const Value.absent(),
    this.projSacks = const Value.absent(),
    this.projTakeaways = const Value.absent(),
    this.projDefTds = const Value.absent(),
    this.projPtsAllowedBaseline = const Value.absent(),
    this.priorYearPts = const Value.absent(),
    this.priorYearSummary = const Value.absent(),
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
    Expression<bool>? isDrafted,
    Expression<double>? injuryRisk,
    Expression<double>? crimeRisk,
    Expression<double>? teamTalentScore,
    Expression<double>? adp,
    Expression<double>? projPassYds,
    Expression<double>? projPassTds,
    Expression<double>? projPassInts,
    Expression<double>? projRushYds,
    Expression<double>? projRushTds,
    Expression<double>? projRec,
    Expression<double>? projRecYds,
    Expression<double>? projRecTds,
    Expression<double>? projFgMade,
    Expression<double>? projFg50Plus,
    Expression<double>? projPatMade,
    Expression<double>? projSacks,
    Expression<double>? projTakeaways,
    Expression<double>? projDefTds,
    Expression<double>? projPtsAllowedBaseline,
    Expression<double>? priorYearPts,
    Expression<String>? priorYearSummary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (nflTeam != null) 'nfl_team': nflTeam,
      if (age != null) 'age': age,
      if (isDrafted != null) 'is_drafted': isDrafted,
      if (injuryRisk != null) 'injury_risk': injuryRisk,
      if (crimeRisk != null) 'crime_risk': crimeRisk,
      if (teamTalentScore != null) 'team_talent_score': teamTalentScore,
      if (adp != null) 'adp': adp,
      if (projPassYds != null) 'proj_pass_yds': projPassYds,
      if (projPassTds != null) 'proj_pass_tds': projPassTds,
      if (projPassInts != null) 'proj_pass_ints': projPassInts,
      if (projRushYds != null) 'proj_rush_yds': projRushYds,
      if (projRushTds != null) 'proj_rush_tds': projRushTds,
      if (projRec != null) 'proj_rec': projRec,
      if (projRecYds != null) 'proj_rec_yds': projRecYds,
      if (projRecTds != null) 'proj_rec_tds': projRecTds,
      if (projFgMade != null) 'proj_fg_made': projFgMade,
      if (projFg50Plus != null) 'proj_fg50_plus': projFg50Plus,
      if (projPatMade != null) 'proj_pat_made': projPatMade,
      if (projSacks != null) 'proj_sacks': projSacks,
      if (projTakeaways != null) 'proj_takeaways': projTakeaways,
      if (projDefTds != null) 'proj_def_tds': projDefTds,
      if (projPtsAllowedBaseline != null)
        'proj_pts_allowed_baseline': projPtsAllowedBaseline,
      if (priorYearPts != null) 'prior_year_pts': priorYearPts,
      if (priorYearSummary != null) 'prior_year_summary': priorYearSummary,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? position,
      Value<String>? nflTeam,
      Value<int>? age,
      Value<bool>? isDrafted,
      Value<double>? injuryRisk,
      Value<double>? crimeRisk,
      Value<double>? teamTalentScore,
      Value<double>? adp,
      Value<double>? projPassYds,
      Value<double>? projPassTds,
      Value<double>? projPassInts,
      Value<double>? projRushYds,
      Value<double>? projRushTds,
      Value<double>? projRec,
      Value<double>? projRecYds,
      Value<double>? projRecTds,
      Value<double>? projFgMade,
      Value<double>? projFg50Plus,
      Value<double>? projPatMade,
      Value<double>? projSacks,
      Value<double>? projTakeaways,
      Value<double>? projDefTds,
      Value<double>? projPtsAllowedBaseline,
      Value<double>? priorYearPts,
      Value<String>? priorYearSummary}) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      nflTeam: nflTeam ?? this.nflTeam,
      age: age ?? this.age,
      isDrafted: isDrafted ?? this.isDrafted,
      injuryRisk: injuryRisk ?? this.injuryRisk,
      crimeRisk: crimeRisk ?? this.crimeRisk,
      teamTalentScore: teamTalentScore ?? this.teamTalentScore,
      adp: adp ?? this.adp,
      projPassYds: projPassYds ?? this.projPassYds,
      projPassTds: projPassTds ?? this.projPassTds,
      projPassInts: projPassInts ?? this.projPassInts,
      projRushYds: projRushYds ?? this.projRushYds,
      projRushTds: projRushTds ?? this.projRushTds,
      projRec: projRec ?? this.projRec,
      projRecYds: projRecYds ?? this.projRecYds,
      projRecTds: projRecTds ?? this.projRecTds,
      projFgMade: projFgMade ?? this.projFgMade,
      projFg50Plus: projFg50Plus ?? this.projFg50Plus,
      projPatMade: projPatMade ?? this.projPatMade,
      projSacks: projSacks ?? this.projSacks,
      projTakeaways: projTakeaways ?? this.projTakeaways,
      projDefTds: projDefTds ?? this.projDefTds,
      projPtsAllowedBaseline:
          projPtsAllowedBaseline ?? this.projPtsAllowedBaseline,
      priorYearPts: priorYearPts ?? this.priorYearPts,
      priorYearSummary: priorYearSummary ?? this.priorYearSummary,
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
    if (isDrafted.present) {
      map['is_drafted'] = Variable<bool>(isDrafted.value);
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
    if (adp.present) {
      map['adp'] = Variable<double>(adp.value);
    }
    if (projPassYds.present) {
      map['proj_pass_yds'] = Variable<double>(projPassYds.value);
    }
    if (projPassTds.present) {
      map['proj_pass_tds'] = Variable<double>(projPassTds.value);
    }
    if (projPassInts.present) {
      map['proj_pass_ints'] = Variable<double>(projPassInts.value);
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
    if (projFgMade.present) {
      map['proj_fg_made'] = Variable<double>(projFgMade.value);
    }
    if (projFg50Plus.present) {
      map['proj_fg50_plus'] = Variable<double>(projFg50Plus.value);
    }
    if (projPatMade.present) {
      map['proj_pat_made'] = Variable<double>(projPatMade.value);
    }
    if (projSacks.present) {
      map['proj_sacks'] = Variable<double>(projSacks.value);
    }
    if (projTakeaways.present) {
      map['proj_takeaways'] = Variable<double>(projTakeaways.value);
    }
    if (projDefTds.present) {
      map['proj_def_tds'] = Variable<double>(projDefTds.value);
    }
    if (projPtsAllowedBaseline.present) {
      map['proj_pts_allowed_baseline'] =
          Variable<double>(projPtsAllowedBaseline.value);
    }
    if (priorYearPts.present) {
      map['prior_year_pts'] = Variable<double>(priorYearPts.value);
    }
    if (priorYearSummary.present) {
      map['prior_year_summary'] = Variable<String>(priorYearSummary.value);
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
          ..write('isDrafted: $isDrafted, ')
          ..write('injuryRisk: $injuryRisk, ')
          ..write('crimeRisk: $crimeRisk, ')
          ..write('teamTalentScore: $teamTalentScore, ')
          ..write('adp: $adp, ')
          ..write('projPassYds: $projPassYds, ')
          ..write('projPassTds: $projPassTds, ')
          ..write('projPassInts: $projPassInts, ')
          ..write('projRushYds: $projRushYds, ')
          ..write('projRushTds: $projRushTds, ')
          ..write('projRec: $projRec, ')
          ..write('projRecYds: $projRecYds, ')
          ..write('projRecTds: $projRecTds, ')
          ..write('projFgMade: $projFgMade, ')
          ..write('projFg50Plus: $projFg50Plus, ')
          ..write('projPatMade: $projPatMade, ')
          ..write('projSacks: $projSacks, ')
          ..write('projTakeaways: $projTakeaways, ')
          ..write('projDefTds: $projDefTds, ')
          ..write('projPtsAllowedBaseline: $projPtsAllowedBaseline, ')
          ..write('priorYearPts: $priorYearPts, ')
          ..write('priorYearSummary: $priorYearSummary')
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
  Value<bool> isDrafted,
  Value<double> injuryRisk,
  Value<double> crimeRisk,
  Value<double> teamTalentScore,
  Value<double> adp,
  Value<double> projPassYds,
  Value<double> projPassTds,
  Value<double> projPassInts,
  Value<double> projRushYds,
  Value<double> projRushTds,
  Value<double> projRec,
  Value<double> projRecYds,
  Value<double> projRecTds,
  Value<double> projFgMade,
  Value<double> projFg50Plus,
  Value<double> projPatMade,
  Value<double> projSacks,
  Value<double> projTakeaways,
  Value<double> projDefTds,
  Value<double> projPtsAllowedBaseline,
  Value<double> priorYearPts,
  Value<String> priorYearSummary,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> position,
  Value<String> nflTeam,
  Value<int> age,
  Value<bool> isDrafted,
  Value<double> injuryRisk,
  Value<double> crimeRisk,
  Value<double> teamTalentScore,
  Value<double> adp,
  Value<double> projPassYds,
  Value<double> projPassTds,
  Value<double> projPassInts,
  Value<double> projRushYds,
  Value<double> projRushTds,
  Value<double> projRec,
  Value<double> projRecYds,
  Value<double> projRecTds,
  Value<double> projFgMade,
  Value<double> projFg50Plus,
  Value<double> projPatMade,
  Value<double> projSacks,
  Value<double> projTakeaways,
  Value<double> projDefTds,
  Value<double> projPtsAllowedBaseline,
  Value<double> priorYearPts,
  Value<String> priorYearSummary,
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

  ColumnFilters<bool> get isDrafted => $composableBuilder(
      column: $table.isDrafted, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get crimeRisk => $composableBuilder(
      column: $table.crimeRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get adp => $composableBuilder(
      column: $table.adp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPassInts => $composableBuilder(
      column: $table.projPassInts, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<double> get projFgMade => $composableBuilder(
      column: $table.projFgMade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projFg50Plus => $composableBuilder(
      column: $table.projFg50Plus, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPatMade => $composableBuilder(
      column: $table.projPatMade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projSacks => $composableBuilder(
      column: $table.projSacks, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projTakeaways => $composableBuilder(
      column: $table.projTakeaways, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projDefTds => $composableBuilder(
      column: $table.projDefTds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get projPtsAllowedBaseline => $composableBuilder(
      column: $table.projPtsAllowedBaseline,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priorYearPts => $composableBuilder(
      column: $table.priorYearPts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priorYearSummary => $composableBuilder(
      column: $table.priorYearSummary,
      builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<bool> get isDrafted => $composableBuilder(
      column: $table.isDrafted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get crimeRisk => $composableBuilder(
      column: $table.crimeRisk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get adp => $composableBuilder(
      column: $table.adp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPassInts => $composableBuilder(
      column: $table.projPassInts,
      builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<double> get projFgMade => $composableBuilder(
      column: $table.projFgMade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projFg50Plus => $composableBuilder(
      column: $table.projFg50Plus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPatMade => $composableBuilder(
      column: $table.projPatMade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projSacks => $composableBuilder(
      column: $table.projSacks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projTakeaways => $composableBuilder(
      column: $table.projTakeaways,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projDefTds => $composableBuilder(
      column: $table.projDefTds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get projPtsAllowedBaseline => $composableBuilder(
      column: $table.projPtsAllowedBaseline,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priorYearPts => $composableBuilder(
      column: $table.priorYearPts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priorYearSummary => $composableBuilder(
      column: $table.priorYearSummary,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<bool> get isDrafted =>
      $composableBuilder(column: $table.isDrafted, builder: (column) => column);

  GeneratedColumn<double> get injuryRisk => $composableBuilder(
      column: $table.injuryRisk, builder: (column) => column);

  GeneratedColumn<double> get crimeRisk =>
      $composableBuilder(column: $table.crimeRisk, builder: (column) => column);

  GeneratedColumn<double> get teamTalentScore => $composableBuilder(
      column: $table.teamTalentScore, builder: (column) => column);

  GeneratedColumn<double> get adp =>
      $composableBuilder(column: $table.adp, builder: (column) => column);

  GeneratedColumn<double> get projPassYds => $composableBuilder(
      column: $table.projPassYds, builder: (column) => column);

  GeneratedColumn<double> get projPassTds => $composableBuilder(
      column: $table.projPassTds, builder: (column) => column);

  GeneratedColumn<double> get projPassInts => $composableBuilder(
      column: $table.projPassInts, builder: (column) => column);

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

  GeneratedColumn<double> get projFgMade => $composableBuilder(
      column: $table.projFgMade, builder: (column) => column);

  GeneratedColumn<double> get projFg50Plus => $composableBuilder(
      column: $table.projFg50Plus, builder: (column) => column);

  GeneratedColumn<double> get projPatMade => $composableBuilder(
      column: $table.projPatMade, builder: (column) => column);

  GeneratedColumn<double> get projSacks =>
      $composableBuilder(column: $table.projSacks, builder: (column) => column);

  GeneratedColumn<double> get projTakeaways => $composableBuilder(
      column: $table.projTakeaways, builder: (column) => column);

  GeneratedColumn<double> get projDefTds => $composableBuilder(
      column: $table.projDefTds, builder: (column) => column);

  GeneratedColumn<double> get projPtsAllowedBaseline => $composableBuilder(
      column: $table.projPtsAllowedBaseline, builder: (column) => column);

  GeneratedColumn<double> get priorYearPts => $composableBuilder(
      column: $table.priorYearPts, builder: (column) => column);

  GeneratedColumn<String> get priorYearSummary => $composableBuilder(
      column: $table.priorYearSummary, builder: (column) => column);
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
            Value<bool> isDrafted = const Value.absent(),
            Value<double> injuryRisk = const Value.absent(),
            Value<double> crimeRisk = const Value.absent(),
            Value<double> teamTalentScore = const Value.absent(),
            Value<double> adp = const Value.absent(),
            Value<double> projPassYds = const Value.absent(),
            Value<double> projPassTds = const Value.absent(),
            Value<double> projPassInts = const Value.absent(),
            Value<double> projRushYds = const Value.absent(),
            Value<double> projRushTds = const Value.absent(),
            Value<double> projRec = const Value.absent(),
            Value<double> projRecYds = const Value.absent(),
            Value<double> projRecTds = const Value.absent(),
            Value<double> projFgMade = const Value.absent(),
            Value<double> projFg50Plus = const Value.absent(),
            Value<double> projPatMade = const Value.absent(),
            Value<double> projSacks = const Value.absent(),
            Value<double> projTakeaways = const Value.absent(),
            Value<double> projDefTds = const Value.absent(),
            Value<double> projPtsAllowedBaseline = const Value.absent(),
            Value<double> priorYearPts = const Value.absent(),
            Value<String> priorYearSummary = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            name: name,
            position: position,
            nflTeam: nflTeam,
            age: age,
            isDrafted: isDrafted,
            injuryRisk: injuryRisk,
            crimeRisk: crimeRisk,
            teamTalentScore: teamTalentScore,
            adp: adp,
            projPassYds: projPassYds,
            projPassTds: projPassTds,
            projPassInts: projPassInts,
            projRushYds: projRushYds,
            projRushTds: projRushTds,
            projRec: projRec,
            projRecYds: projRecYds,
            projRecTds: projRecTds,
            projFgMade: projFgMade,
            projFg50Plus: projFg50Plus,
            projPatMade: projPatMade,
            projSacks: projSacks,
            projTakeaways: projTakeaways,
            projDefTds: projDefTds,
            projPtsAllowedBaseline: projPtsAllowedBaseline,
            priorYearPts: priorYearPts,
            priorYearSummary: priorYearSummary,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String position,
            required String nflTeam,
            required int age,
            Value<bool> isDrafted = const Value.absent(),
            Value<double> injuryRisk = const Value.absent(),
            Value<double> crimeRisk = const Value.absent(),
            Value<double> teamTalentScore = const Value.absent(),
            Value<double> adp = const Value.absent(),
            Value<double> projPassYds = const Value.absent(),
            Value<double> projPassTds = const Value.absent(),
            Value<double> projPassInts = const Value.absent(),
            Value<double> projRushYds = const Value.absent(),
            Value<double> projRushTds = const Value.absent(),
            Value<double> projRec = const Value.absent(),
            Value<double> projRecYds = const Value.absent(),
            Value<double> projRecTds = const Value.absent(),
            Value<double> projFgMade = const Value.absent(),
            Value<double> projFg50Plus = const Value.absent(),
            Value<double> projPatMade = const Value.absent(),
            Value<double> projSacks = const Value.absent(),
            Value<double> projTakeaways = const Value.absent(),
            Value<double> projDefTds = const Value.absent(),
            Value<double> projPtsAllowedBaseline = const Value.absent(),
            Value<double> priorYearPts = const Value.absent(),
            Value<String> priorYearSummary = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            name: name,
            position: position,
            nflTeam: nflTeam,
            age: age,
            isDrafted: isDrafted,
            injuryRisk: injuryRisk,
            crimeRisk: crimeRisk,
            teamTalentScore: teamTalentScore,
            adp: adp,
            projPassYds: projPassYds,
            projPassTds: projPassTds,
            projPassInts: projPassInts,
            projRushYds: projRushYds,
            projRushTds: projRushTds,
            projRec: projRec,
            projRecYds: projRecYds,
            projRecTds: projRecTds,
            projFgMade: projFgMade,
            projFg50Plus: projFg50Plus,
            projPatMade: projPatMade,
            projSacks: projSacks,
            projTakeaways: projTakeaways,
            projDefTds: projDefTds,
            projPtsAllowedBaseline: projPtsAllowedBaseline,
            priorYearPts: priorYearPts,
            priorYearSummary: priorYearSummary,
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
