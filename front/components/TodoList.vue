<template>
  <v-card>
    <!-- 編集画面 -->
    <v-card-title>
      <h2>TODO</h2>
      <v-spacer></v-spacer>
      <!-- <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field> -->
      <!-- 残してもいいかも -->
    </v-card-title>
    <v-data-table :headers="headers" :items="todos" :search="search">
      <!-- ここにアイテムの名前が表示される/itemsをitemに入れるのがv-data-tableの機能-->

      <template v-slot:item.point="props">
        <v-edit-dialog :return-value.sync="props.item.point">
          {{ props.item.point }}
          <template v-slot:input>
            <v-select
              @change="updatePoint(props.item.id, props.item.point)"
              v-model="props.item.point"
              :items="items"
              single-line
            ></v-select>
            <!-- itemsは元々v-selectに存在している -->
          </template>
        </v-edit-dialog>
      </template>

      <template v-slot:item.title="props">
        <v-edit-dialog :return-value.sync="props.item.title">
          {{ props.item.title }}
          <template v-slot:input>
            <v-text-field
              @change="updateTitle(props.item.id, props.item.title)"
              v-model="props.item.title"
              label="Edit"
              single-line
              counter
            ></v-text-field>
          </template>
        </v-edit-dialog>
      </template>

      <template v-slot:item.action="{ item }">
        <v-icon midium @click="deleteItem(item)">delete</v-icon>
      </template>

      <template v-slot:item.complete="{ item }">
        <v-icon big @click="completeItem(item)">mdi-heart</v-icon>
        <!-- やったことを送信する -->
      </template>
        <!-- 編集ボタン -->
        <!-- <div v-if="editOn"></div>
        <div v-else class="edit-window">
          <p>編集画面</p>
          <v-text-field label="Edit" counter></v-text-field>
          <v-icon smaill @click="changeItem">update</v-icon>
        </div>-->
    </v-data-table>
  </v-card>
</template>


<script>
  const maxNumber = 11; //表示したい数字より+1で設定。
  const numberRange = [...Array(maxNumber).keys()]
import axios from "@/plugins/axios";
export default {
  props: ["todos"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      search: "",
      editOn: true,
      items: numberRange,
      headers: [
        {
          text: "check",
          width: "170",
          value: "complete"
        },
        {
          text: "TP",
          value: "point",
          width: "170"
          // 幅の固定もできる
        },
        // これ押したらチェックするみたいな感じにしたい
        {
          text: "content",
          align: "left",
          sortable: false,
          value: "title"
        },
        // { text: "ユーザー名", value: "username" },
        {
          text: "delete",
          value: "action",
          sortable: false
        }
      ]
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async deleteItem(item) {
      const res = confirm("本当に削除しますか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`);
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
      }
    },
    // 完了メソッド
    async completeItem(item) {
      const res = confirm("本当に達成しますか？");
      if (res) {
        await axios.get(`/v1/todos/${item.id}`, {
          params: {
            point: this.todos[0].point
          }
        });
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        this.user.point = this.user.point + this.todos[0].point;
        // ポイントを加算
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
        // ミューテーションに飛ばす
      }
    },
    async editItem(item) {
      this.editOn = !this.editOn;
    },
    async updateTitle(id, value) {
      await axios.patch(`/v1/todos/${id}`, {
        todo: {
          title: value
        }
      });
    },
    async updatePoint(id, value) {
      await axios.patch(`/v1/todos/${id}`, {
        todo: {
          point: value
        }
      });
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
