<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">ごほうびリスト</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable class="pl-0" v-model="rewards" :options="{ animation: 200, delay: 50 }" @end="atEnd" element="ul">
        <li id="v-step-1" class="reward-list" v-for="reward in rewards" :key="reward.sort">
          <v-icon size="30px">mdi-numeric-{{ reward.point }}-box-outline</v-icon>
          <v-hover v-slot:default="{ hover }">
            <v-icon v-if="!reward.status" @click="openCompleteDialog(reward)" size="25px" color="blue"
              v-text="hover ? 'mdi-heart' : 'mdi-heart-outline'">
            </v-icon>
            <v-icon v-else size="25px" color="blue">check </v-icon>
          </v-hover>
          <span class="reward-title">{{ reward.title }}</span>
          <div class="reward-list-icon">
            <v-icon v-if="reward.status" big color="yellow">lock_open</v-icon>
            <v-icon v-else big color="red">lock</v-icon>
            <v-icon v-if="!reward.status" @click="editItem(reward); open(reward)" big>mdi-pencil-plus</v-icon>
            <v-icon midium @click="openDeleteDialog(reward)">delete</v-icon>
          </div>
        </li>
      </draggable>
    </v-card>

    <v-dialog v-model="completeDialog">
      <v-card>
        <v-card-title>『{{selectedItem.title}}』を達成しますか？</v-card-title>
        <v-btn @click="completeItem(selectedItem)">はい</v-btn>
        <v-btn @click="completeDialog = false">いいえ</v-btn>
      </v-card>
    </v-dialog>

    <v-dialog v-model="deleteDialog">
      <v-card>
        <v-card-title>『{{selectedItem.title}}』を削除しますか？</v-card-title>
        <v-btn @click="deleteItem(selectedItem)">はい</v-btn>
        <v-btn @click="deleteDialog = false">いいえ</v-btn>
      </v-card>
    </v-dialog>

    <v-dialog class="edit-dialog" v-model="dialog">
      <v-card>
        <v-card-title>
          <h2 class="list-title">ごほうび編集</h2>
        </v-card-title>
        <p>内容</p>
        <v-text-field class="dialog-title" v-model="dialogText.title" filled></v-text-field>
        <p class="errormsg">{{ errorMsg }}</p>
        <p>ポイント</p>
        <v-select class="dialog-point" single-line :items="items" v-model="dialogText.point" :value="dialogText.point"
          filled></v-select>
        <v-btn class="update-btn" @click="updateItem(dialogText.id, dialogText.title, dialogText.point)">保存</v-btn>
      </v-card>
    </v-dialog>


    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
  const numberRange = [...Array(9).keys()].map(i => ++i);

  import axios from "@/plugins/axios";
  export default {
    props: ["rewards"],
    data() {
      return {
        singleSelect: true,
        selected: [],
        search: "",
        editOn: true,
        items: numberRange,
        snack: false,
        snackColor: "",
        snackText: "",
        dialogText: "",
        dialog: false,
        deleteDialog: false,
        completeDialog: false,
        selectedItem: "",
        dialogReward: {},
        errorMsg: "",
      };
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      async deleteItem(item) {
        const getUser = await axios.delete(`/v1/rewards/${item.id}`);
        const rewards = this.user.rewards.filter(reward => {
          return reward.id !== item.id;
        });
        const updateUser = {
          ...this.user,
          user: getUser.data.user,
          rewards,
        };
        this.$store.commit("setUser", updateUser);
        this.snack = true;
        this.snackColor = "warning";
        this.snackText = "削除しました。";
        this.deleteDialog = false;
      },
      async completeItem(item) {
        try {
          const getUser = await axios.get(`/v1/rewards/${item.id}`, {
            params: {
              point: item.point
            }
          });
          const todos = getUser.data.todos;
          const rewards = this.user.rewards;
          const updateUser = {
            user: getUser.data.user,
            rewards,
            todos,
            untilPercentage: getUser.data.untilPercentage,
            untilLevel: getUser.data.untilLevel
          };
          this.$store.commit("setUser", updateUser);
          item.status = true;
          this.user.rewards.status = true;
          this.snack = true;
          this.snackColor = "success";
          this.snackText = "ごほうびを解放した！";
          this.completeDialog = false;
          this.$store.commit("clearErrors");
        } catch (error) {
          console.log("UserPage: 110", error);
          const {
            data
          } = error.response;
          this.$store.commit("setError", data.error_msg);
          this.completeDialog = false;
        }
      },
      async editItem(reward) {
        console.log(reward);
        this.dialog = true;
        // 参照渡し（入力の際の文章を受け取る役割をしています）
        this.dialogReward = reward;
        this.dialogText = {
          id: reward.id,
          title: reward.title,
          point: reward.point
        };
      },
      async updateItem(id, title, point) {
        if (!title) {
          this.errorMsg = "タイトルが空欄です。"
          return console.log("空欄")
        } else if (title.length >= 20) {
          this.errorMsg = "タイトルは1文字以上20文字以下にしてください。"
          return console.log("文字が多い")
        }
        await axios.patch(`/v1/rewards/${id}`, {
          reward: {
            title: title,
            point: point
          }
        });
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "保存しました。";
        this.dialogReward.title = title;
        this.dialogReward.point = point;
        this.dialog = false;
      },
      async atEnd() {
        await axios.patch(`v1/rewards`, {
          reward: this.rewards
        });
        const updateUser = {
          ...this.user,
          rewards: this.rewards
        };
        this.$store.commit("setUser", updateUser);
      },
      save() {
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "保存しました。";
      },
      cancel() {
        this.snack = true;
        this.snackColor = "error";
        this.snackText = "Canceled";
      },
      open(name) {
        this.snack = true;
        this.snackColor = "info";
        this.snackText = "『" + name.title + "』" + "を編集します。";
      },
      close() {
        console.log("Dialog closed");
      },
      openCompleteDialog(reward) {
        this.completeDialog = true;
        this.selectedItem = reward;
      },
      openDeleteDialog(reward) {
        this.deleteDialog = true;
        this.selectedItem = reward;
      }
    },
    watch: {}
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;
  $accent-color: #f0353f;

  @mixin btn {
    background-color: rgb(29, 29, 29) !important;
    border: 2px solid $main-color;
    color: $main-color !important;
    display: inline-block;
    margin: 0px 5% 15px;
    width: 70%;
    font-weight: bold;
  }

  .v-icon {
    display: flex;
    justify-content: center;
  }

  .edit-window {
    z-index: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 30, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .reward-list {
    display: flex;
    list-style: none;
    border-left: solid 8px rgb(255, 255, 99) !important;
    border-bottom: solid 2px rgb(121, 117, 117) !important;
    color: rgb(19, 32, 16);
    margin: 10px;
    padding: 10px;
    border: 1px solid #7f7f7f;
    border-radius: 6px;
    background-color: #a0e09a;
    cursor: grab;

    .reward-list-icon {
      margin-left: auto;
    }

    .reward-list-btn {
      background-color: rgb(206, 204, 87) !important;
    }

    .reward-title {
      padding-top: 2px;
      margin-left: 10px;
      max-width: 35%;
    }

    .reward-point {
      color: rgb(41, 79, 160);
      font-weight: bold;
      display: inline-block;
      width: 25px;
      border-radius: 50%;
      text-align: center;
      background: rgb(250, 253, 71);
      color: $sub-color;
      box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.08);
      border-bottom: solid 2px #b1a60c;
    }
  }

  .v-dialog {
    width: 70%;

    h2 {
      color: $sub-color;
    }

    p {
      margin-left: 5%;
    }

    .dialog-title {
      width: 90%;
      margin: 0 auto;
    }

    .dialog-point {
      width: 40%;
      margin-left: 5%;
    }

    .update-btn {
      @include btn;
    }
  }

  .errormsg {
    color: red;
  }
</style>
