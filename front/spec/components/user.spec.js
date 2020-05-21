import Vue from 'vue'
import Vuetify from 'vuetify'
import { createLocalVue, mount, shallowMount } from '@vue/test-utils'
import user from '@/pages/user.vue'

Vue.use(Vuetify)

const localVue = createLocalVue()

describe('CustomCard.vue', () => {
  let vuetify
  let wrapper
  beforeEach(() => {
    vuetify = new Vuetify()
    wrapper = mount(user, {
      localVue,
      vuetify,
    })
  })
  test("TODOが追加されること", () => {
    console.log(wrapper);
    expect(wrapper.vm.todo.point).toBe("1");
  });
})
// import user from "@/pages/user";
// import { mount, createLocalVue } from "@vue/test-utils";
// import Vuetify from "vuetify";
// import Vuex from "vuex";
// import * as store from "@/store";

// let wrapper;
// let vuetify;

// const localVue = createLocalVue();
// localVue.use(Vuex);

// beforeEach(() => {
//   vuetify = new Vuetify();
//   wrapper = mount(user, {
//     computed: {
//       currentUser() {
//         return 1
//       }
//     },
//     propsData: {
//       experience_point: "",
//       show1: false,
//       show2: false,
//       error: "",
//       showContent: false
//     },
//     store: store,
//     localVue,
//     vuetify
//   });
// });
