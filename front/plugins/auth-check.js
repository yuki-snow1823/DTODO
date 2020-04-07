import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({
  store,
  redirect
}) => {
  firebase.auth().onAuthStateChanged(async user => {
    if (user) {
      const {
        data
      } = await axios.get(`/v1/users?uid=${user.uid}`)
      store.commit("setUser", data)
      console.log("hoge");
    } else {
      store.commit("setUser", null)
      console.log("hoge2");
    }
  });
}

export default authCheck
