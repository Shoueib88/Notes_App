abstract class NoteState {}

class InitNoteState extends NoteState {
  InitNoteState() {
    print('initstate');
  }
}

// InsertDataBase state
class InsertDataBaseSuccess extends NoteState {}

class InsertDataBaseError extends NoteState {}

// DeleteDataBase state
class DeleteDataBaseSuccess extends NoteState {}

class DeleteDataBaseError extends NoteState {}

// UpdateDataBase state
class UpdateDataBaseSuccess extends NoteState {}

//class UpdateDataBaseError extends NoteState {}

// GetDataBase state
class GetDataBaseLoading extends NoteState {}

class GetDataBaseSuccess extends NoteState {}

class GetDataBaseError extends NoteState {}
