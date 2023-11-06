// ignore_for_file: public_member_api_docs, sort_constructors_first
class Terminal {
  final bool isAssociated;
  final String remoteName;
  final String? associatedName;


  const Terminal({
    this.isAssociated = false,
    this.associatedName,
    required this.remoteName,
  
  });


  @override
  String toString() => 'Terminal(isAssociated: $isAssociated, name: $associatedName)';
}
