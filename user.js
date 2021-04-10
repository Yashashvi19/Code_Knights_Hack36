let users = [];

function joinUser(chatId, userName, roomName) {
  const user = {
    id: chatId,
    roomName: roomName,
    userName: userName,
  };
  users.push(user);

  return user;
}
function getList() {
  return users;
}

function removeUser(chatId) {
  let getId = (users) => {
    users.id === chatId;
  };
  const index = users.findIndex(getId);
  if (index !== -1) {
    return users.splice(index, 1)[0];
  }
}
module.exports = { joinUser, removeUser };
