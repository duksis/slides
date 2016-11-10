defmodule InterviewInvites do
  use GenServer

  # Client API
  def start do
    {:ok, invites} = GenServer.start(__MODULE__, [])
    invites
  end

  def send_invite(invites, invite) when is_binary(invite) do
    GenServer.cast(invites, {:add, invite})
  end

  def list_invites(invites) do
    GenServer.call(invites, {:list})
  end

  # Server API
   def handle_cast({:add, invite}, invites) do
     {:noreply, [invite | invites]}
   end

   def handle_call({:list}, _from, invites) do
     {:reply, invites, invites}
   end
end

# c("GenServer_example.ex")
## [Invites]
# invites = InterviewInvites.start
## #PID<0.88.0>
# InterviewInvites.list_invites(invites)
## []
# InterviewInvites.send_invite(invites, "Backend Developer (Elicxir)")
## :ok
# InterviewInvites.list_invites(invites)
## ["Backend Developer (Elicxir)"]
