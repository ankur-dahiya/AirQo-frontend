part of 'kya_bloc.dart';

@JsonSerializable()
class KyaState extends Equatable {
  const KyaState({
    required this.lessons,
    required this.quizzes,
  });

  factory KyaState.fromJson(Map<String, dynamic> json) =>
      _$KyaStateFromJson(json);

  Map<String, dynamic> toJson() => _$KyaStateToJson(this);

  KyaState copyWith({
    List<KyaLesson>? lessons,
    List<Quiz>? quizzes,
  }) =>
      KyaState(
        lessons: lessons ?? this.lessons,
        quizzes: quizzes ?? this.quizzes,
      );

  final List<KyaLesson> lessons;
  final List<Quiz> quizzes;

  @override
  List<Object> get props {
    List<String> props = lessons.map((e) => e.activeTask.toString()).toList();
    props.addAll(lessons.map((e) => e.id).toList());
    props.addAll(lessons.map((e) => e.tasks.length.toString()).toList());
    props.addAll(lessons.map((e) => e.status.toString()).toList());
    props.add(lessons.length.toString());
    props.addAll(quizzes.map((e) => e.activeQuestion.toString()).toList());
    props.addAll(quizzes.map((e) => e.id).toList());
    props.addAll(quizzes.map((e) => e.questions.length.toString()).toList());
    props.addAll(quizzes.map((e) => e.status.toString()).toList());
    props.add(quizzes.length.toString());
    return props;
  }
}
