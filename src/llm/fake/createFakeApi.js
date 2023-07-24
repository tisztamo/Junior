export default function createFakeApi() {
  return {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  };
}
