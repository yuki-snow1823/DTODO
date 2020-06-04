<template>
  <v-dialog v-model="prop_deleteDialog">
    <v-card>
      <v-card-title>『{{ prop_selectedItem.title }}』を削除しますか？</v-card-title>
      <v-btn @click="handleSubmit(prop_selectedItem)">はい</v-btn>
      <v-btn @click="closeDialog()">いいえ</v-btn>
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
      // prop_deleteDialog: this.prop_deleteDialog
    };
  },
  methods: {
    handleSubmit(selectedItem) {
      this.$emit("delete", selectedItem);
    },
    closeDialog(){
      this.$emit("close");
    }
  }
};
</script>

<style lang="scss"></style>
