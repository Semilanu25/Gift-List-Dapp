import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Time "mo:base/Time";

actor {
  type GiftId = Nat;
  
  type Gift = {
    id : GiftId;
    recipient : Text;
    item : Text;
    occasion : Text;
    date : Time.Time;
  };

  var gifts = Buffer.Buffer<Gift>(0);

  public func addGift(recipient : Text, item : Text, occasion : Text) : async GiftId {
    let giftId = gifts.size();
    let newGift : Gift = {
      id = giftId;
      recipient = recipient;
      item = item;
      occasion = occasion;
      date = Time.now();
    };
    gifts.add(newGift);
    giftId;
  };

  public query func getGift(giftId : GiftId) : async ?Gift {
    if (giftId < gifts.size()) {
      ?gifts.get(giftId);
    } else {
      null;
    };
  };

  public query func getAllGifts() : async [Gift] {
    Buffer.toArray(gifts);
  };

  public query func getGiftsByRecipient(recipient : Text) : async [Gift] {
    let results = Buffer.Buffer<Gift>(0);
    for (gift in gifts.vals()) {
      if (Text.equal(gift.recipient, recipient)) {
        results.add(gift);
      };
    };
    Buffer.toArray(results);
  };
};