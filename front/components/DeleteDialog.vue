<template>
  <v-dialog v-model="prop_deleteDialog">
    <v-card>
      <v-card-title>『{{ selectedItem.title }}』を削除しますか？</v-card-title>
      <v-btn @click="handleSubmit(selectedItem)">はい</v-btn>
      <v-btn @click="handleSubmit2()">いいえ</v-btn>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    prop_deleteDialog: {
      type: Boolean,
      default: () => false,
      required: true
    },
    prop_selectedItem: {
      // type: String,
      // default: () => "",
      // required: true
    }
  },
  data() {
    return {
      deleteDialog: this.prop_deleteDialog,
      selectedItem: this.prop_selectedItem
    };
  },
  methods: {
    handleSubmit(selectedItem) {
      this.$emit("delete", selectedItem);
    },
    handleSubmit2() {
      this.$emit("open", selectedItem);
    }
  }
};
</script>

<style lang="scss"></style>
