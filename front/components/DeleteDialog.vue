<template>
  <v-dialog v-model="deleteDialog">
    <v-card>
      <v-card-title>『{{ selectedItem.title }}』を削除しますか？</v-card-title>
      <v-btn @click="deleteItem(selectedItem)">はい</v-btn>
      <v-btn @click="deleteDialog = false">いいえ</v-btn>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    prop_snack: {
      type: Boolean,
      default: false,
      required: true
    },
    prop_snackColor: {
      type: String,
      default: () => "",
      required: true
    },
    prop_snackText: {
      type: String,
      default: () => "",
      required: true
    }
  },
  data() {
    return {
        dialog: false,
        deleteDialog: false,
        selectedItem: "",
    };
  },
  methods: {
    openDeleteDialog(todo) {
      this.deleteDialog = true;
      this.selectedItem = todo;
    },
    async deleteItem(item) {
      await axios.delete(`/v1/todos/${item.id}`);
      const todos = this.user.todos.filter(todo => {
        return todo.id !== item.id;
      });
      const updateUser = {
        ...this.user,
        todos
      };
      this.$store.commit("setUser", updateUser);
      this.snack = true;
      this.snackColor = "warning";
      this.snackText = "削除しました。";
      this.deleteDialog = false;
    }
  }
};
</script>

<style lang="scss"></style>
