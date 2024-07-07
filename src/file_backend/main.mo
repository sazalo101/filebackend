import TrieMap "mo:base/TrieMap";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Iter "mo:base/Iter";

actor FileStorage {
  type File = {
    id : Int;
    name : Text;
    content : Blob;
    owner : Text;
  };

  var files : TrieMap.TrieMap<Int, File> = TrieMap.TrieMap(Int.equal, Int.hash);
  var nextFileId : Int = 0;

  public func uploadFile(name : Text, content : Blob, owner : Text) : async Int {
    let fileId = nextFileId;
    nextFileId += 1;
    files.put(fileId, { id = fileId; name = name; content = content; owner = owner });
    fileId
  };

  public query func getFile(fileId : Int) : async ?File {
    files.get(fileId)
  };

  public query func listFiles() : async [File] {
    Iter.toArray(files.vals())
  };
};
