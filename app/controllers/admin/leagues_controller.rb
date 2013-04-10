class Admin::LeaguesController < Admin::AbstractController
  # GET /leagues
  # GET /leagues.json


  def index
    @leagues = League.all

    respond_to do |format|
      format.html {render :"index",notice => params[:notice]?params[:notice]:nil}# index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html {render 'show',:layout => 'league'}# show.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    @league = League.new

    respond_to do |format|
      format.html {render :'new'}# new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(params[:league])

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render json: @league, status: :created, location: @league }
      else
        format.html { render action: "new" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  def add_users
    @users = User.all
    @league = League.find(params[:league_id])
    respond_to do |format|
      format.html { render  :'add_users' , :layout=>'league', :notice => params[:notice]?params[:notice]:nil}
      format.json { head :no_content }
    end
  end


  def save_users
    param_hash = params[:user_ids]
    @league = params[:league_id]? League.find(params[:league_id]):nil
    if !param_hash.nil?
      (0..Integer(params[:count])).each do |i|
          @param_hash = params[:user_ids]
            if @param_hash[:"#{i}"]
              user = User.find(param_hash[:"#{i}"])
              if user!=nil
                user_league = UserLeagueAssociation.find(user.id,@league.id)
              end
              if user_league==nil
                UserLeagueAssociation.create(:user_id => user.id, :league_id=>@league.id)
              end

            end
        end
    end
    respond_to do |format|
      if !param_hash.nil?
        format.html { redirect_to @league, :method => :get,notice => "Users have been successfully added to #{@league.title}"}
      else
        format.html { redirect_to :action =>'add_users', notice => "No User is selected"}
      end
    end
    end

end
