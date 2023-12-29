extension BranchBool on bool {
  T? branch<T>({T? ifTrue, T? ifFalse}) => this ? ifTrue : ifFalse;
}
