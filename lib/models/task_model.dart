import 'dart:convert';

class TaskModel {
  String? tarefa;
  String? descricao;
  bool? concluida;
  bool? eFavorita;
  DateTime? data;
  TaskModel({
    this.tarefa,
    this.descricao,
    this.concluida = false,
    this.eFavorita = false,
    this.data,
  });

  TaskModel copyWith({
    String? tarefa,
    String? descricao,
    bool? concluida,
    bool? eFavorita,
    DateTime? data,
  }) {
    return TaskModel(
      tarefa: tarefa ?? this.tarefa,
      descricao: descricao ?? this.descricao,
      concluida: concluida ?? this.concluida,
      eFavorita: eFavorita ?? this.eFavorita,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tarefa': tarefa,
      'descricao': descricao,
      'concluida': concluida,
      'eFavorita': eFavorita,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      tarefa: map['tarefa'],
      descricao: map['descricao'],
      concluida: map['concluida'],
      eFavorita: map['eFavorita'],
      data: DateTime.fromMillisecondsSinceEpoch(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(tarefa: $tarefa, descricao: $descricao, concluida: $concluida, eFavorita: $eFavorita, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.tarefa == tarefa &&
        other.descricao == descricao &&
        other.concluida == concluida &&
        other.eFavorita == eFavorita &&
        other.data == data;
  }

  @override
  int get hashCode {
    return tarefa.hashCode ^
        descricao.hashCode ^
        concluida.hashCode ^
        eFavorita.hashCode ^
        data.hashCode;
  }
}
