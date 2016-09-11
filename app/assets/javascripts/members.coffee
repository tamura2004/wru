class BsDropBtn
  template: '''
    <button
      type="button"
      area-expanded="true"
      area-haspopup="true"
      class="btn btn-block dropdown-toggle"
      data-toggle="dropdown"
    >
      <slot></slot>
    </button>
  '''

class DropBtn
  props: ['member']
  components: bsdropbtn: new BsDropBtn
  template: '''
    <bsdropbtn :class="member.color" :id="member.uid">
      <h4>{{member.name}}</h4>
      <small>{{member.label}}</small>
    </bsdropbtn>
  '''

class DropList
  props: ['member','states','handleClick']
  template: '''
    <ul :area-labelledby="member.uid" class="dropdown-menu">
      <li v-for="state in states">
        <a
          @click.prevent="handleClick(state.color)"
        >
          {{state.label}}
        </a>
      </li>
    </ul>
  '''

class SeatBtn
  props: ['member','states','csrftoken']
  components:
    dropbtn: new DropBtn
    droplist: new DropList

  methods:
    handleClick: (color) ->
      @member.color = color
      for state in @states when state.color is color
        @member.label = state.label
        @member.state_id = state.id

      @$http.patch(
        "/members/#{@member.id}.json",
        @member,
        headers: "X-CSRF-Token": @csrftoken
      ).then(
        (response) -> console.log response.data
        (response) -> alert response.data
      )

  template: '''
    <div class="dropdown">
      <dropbtn :member="member"></dropbtn>
      <droplist
        :member="member"
        :states="states"
        :handle-click="handleClick"
      >
      </droplist>
    </div>
  '''

class SeatPanel
  props: ['members','states']
  components:
    seatbtn: new SeatBtn
  created: ->
    @csrftoken = document.querySelector("meta[name=csrf-token]").content
    # @csrfheader = headers: "X-CSRF-Token": csrftoken
  template: '''
    <div class="row">
      <div class="col-xs-1" v-for="col in 12">
        <seatbtn
          v-for="member in cols(col)"
          :member="member"
          :states="states"
          :csrftoken="csrftoken"
        >
        </seatbtn>
      </div>
    </div>
  '''
  methods:
    cols: (col) ->
      x for x in @members when x.col is col

$(document).on "turbolinks:load", ->

  new Vue
    el: "body"
    components:
      seatpanel: new SeatPanel


