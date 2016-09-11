class DropBtn
  props: ['member']
  template: '''
    <button
      :class="member.color"
      :id="member.uid"
      area-expanded="true"
      area-haspopup="true"
      class="btn btn-block dropdown-toggle"
      data-toggle="dropdown"
      type="button"
    >
      <h4 v-text="member.name"></h4>
      <small v-text="member.label"></small>
    </button>
  '''

class DropList
  props: ['member','states']
  template: '''
    <ul :area-labelledby="member.uid" class="dropdown-menu">
      <li v-for="state in states">
        <a
          @click.prevent="notify(state.color)"
          href="#"
          v-text="state.label"
        >
        </a>
      </li>
    </ul>
  '''
  methods:
    notify: (color) ->
      @$dispatch "click", color

class SeatBtn
  props: ['member','states']
  components:
    dropbtn: new DropBtn
    droplist: new DropList

  created: ->
    @resource = Vue.resource "members{/id}"

  methods:
    handleClick: (color) ->
      @member.color = color
      for state in @states when state.color is color
        @member.label = state.label
        @member.state_id = state.id

      @resource.update(id:@member.id,@member).then(
        (response) -> console.log response.data
        (response) -> alert response.data
      )

  template: '''
    <div class="dropdown">
      <dropbtn :member="member"></basebtn>
      <droplist
        :member="member"
        :states="states"
        @click="handleClick"
      >
      </droplist>
    </div>
  '''

class SeatPanel
  props: ['members','states']
  components:
    seatbtn: new SeatBtn
  template: '''
    <div class="row">
      <div class="col-xs-1" v-for="col in 12">
        <seatbtn
          v-for="member in cols(col)"
          :member="member"
          :states="states"
        >
        </seatbtn>
      </div>
    </div>
  '''
  methods:
    cols: (col) ->
      x for x in @members when x.col is col

$ ->
  new Vue
    el: "body"
    components:
      seatpanel: new SeatPanel


