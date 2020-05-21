import user from "@/pages/user";
import { mount, createLocalVue } from "@vue/test-utils";
import Vuex from "vuex";
import * as store from "@/store";

let wrapper;

const localVue = createLocalVue();
localVue.use(Vuex);

beforeEach(() => {
  wrapper = mount(user, {
    store: store,
    localVue
  });
});

describe('CustomCard.vue', () => {
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
