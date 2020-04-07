<template>
  <div>
    <v-card>
      <v-card-title>
        <h2>Reward</h2>
        <v-spacer></v-spacer>
        <!-- <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field> -->
        <!-- 残してもいいかも -->
      </v-card-title>
      <v-data-table :headers="headers" :items="rewards" :search="search">
        <!-- ここにアイテムの名前が表示される/itemsをitemに入れるのがv-data-tableの機能-->

        <template v-slot:item.point="props">
          <v-edit-dialog :return-value.sync="props.item.point" @save="save" @cancel="cancel" @open="open" @close="close">
            {{ props.item.point }}
            <template v-slot:input>
              <v-select @change="updatePoint(props.item.id, props.item.point)" @save="save" @cancel="cancel"
                @open="open" @close="close" v-model="props.item.point" :items="items" single-line></v-select>
              <!-- itemsは元々v-selectに存在している -->
            </template>
          </v-edit-dialog>
        </template>

        <template v-slot:item.title="props">
          <v-edit-dialog @save="save" @cancel="cancel" @open="open" @close="close"
            :return-value.sync="props.item.title">
            {{ props.item.title }}
            <template v-slot:input>
              <v-text-field @change="updateTitle(props.item.id, props.item.title)" v-model="props.item.title"
                label="Edit" single-line counter></v-text-field>
            </template>
          </v-edit-dialog>
        </template>

        <template v-slot:item.action="{ item }">
          <v-icon midium @click="deleteItem(item)">delete</v-icon>
        </template>

        <template v-slot:item.complete="{ item }">
          <v-icon v-if="item.status" big color="yellow" @click="completeItem(item)">lock_open</v-icon>
          <v-icon v-else big color="yellow" @click="completeItem(item)">lock</v-icon>
        </template>

      </v-data-table>
    </v-card>

    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>

  </div>

</template>


<script>
  const maxNumber = 11; //表示したい数字より+1で設定。
  const numberRange = [...Array(maxNumber).keys()]
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
        headers: [{
            text: "状態",
            width: "170",
            value: "complete"
          },
          {
            text: "消費TP",
            value: "point",
            width: "170"
            // 幅の固定もできる
          },
          // これ押したらチェックするみたいな感じにしたい
          {
            text: "内容",
            align: "left",
            sortable: false,
            value: "title"
          },
          // { text: "ユーザー名", value: "username" },
          {
            text: "削除",
            value: "action",
            sortable: false
          }
        ]
      };
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      },
    },
    methods: {
      async deleteItem(item) {
        const res = confirm("本当に削除しますか？");
        if (res) {
          await axios.delete(`/v1/rewards/${item.id}`);
          const rewards = this.user.rewards.filter(reward => {
            return reward.id !== item.id;
          });
          const newUser = {
            ...this.user,
            rewards
          };
          this.$store.commit("setUser", newUser);
          this.snack = true;
          this.snackColor = "warning";
          this.snackText = "Data deleted";
        }
      },
      // 完了メソッド
      async completeItem(item) {
        const res = confirm("本当に達成しますか？");
        if (res) {
          await axios.get(`/v1/rewards/${item.id}`, {
            params: {
              point: item.point
            }
          });
          item.status = true;
          const rewards = this.rewards
          this.user.point = this.user.point - item.point;
          const newUser = {
            ...this.user,
            rewards
          };
          this.$store.commit("setUser", newUser);
          this.snack = true;
          this.snackColor = "success";
          this.snackText = "Data saved";
          // ここに宝箱の状態を切り替えるメソッドを入れる
          console.log(item.point);
          
        }
      },
      async editItem(item) {
        this.editOn = !this.editOn;
      },
      async updateTitle(id, value) {
        await axios.patch(`/v1/rewards/${id}`, {
          reward: {
            title: value
          }
        });
      },
      async updatePoint(id, value) {
        await axios.patch(`/v1/rewards/${id}`, {
          reward: {
            point: value
          }
        });
      },
      save() {
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "Data saved";
      },
      cancel() {
        this.snack = true;
        this.snackColor = "error";
        this.snackText = "Canceled";
      },
      open() {
        this.snack = true;
        this.snackColor = "info";
        this.snackText = "Dialog opened";
      },
      close() {
        console.log("Dialog closed");
      }
    }
  };
</script>

<style>
  .v-icon {
    display: flex;
    justify-content: center;
  }

  .edit-window {
    /*　要素を重ねた時の順番　*/
    z-index: 1;

    /*　画面全体を覆う設定　*/
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 30, 0.5);

    /*　画面の中央に要素を表示させる設定　*/
    display: flex;
    align-items: center;
    justify-content: center;
  }

</style>
