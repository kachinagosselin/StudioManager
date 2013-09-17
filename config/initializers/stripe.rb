if(Rails.env.development? || Rails.env.staging?)
    Stripe.api_key = "sk_test_I4Ci5lTRq3QtUQsejxMZBk71"
    STRIPE_PUBLIC_KEY = "pk_test_mYKdLY06r0ydfyWApf5lQiyq"
elsif(Rails.env.production?)
    Stripe.api_key = "sk_live_8f9azcagKaJAEXWSyGRJBI4Q"
    STRIPE_PUBLIC_KEY = "pk_live_z25J6XHIB8rmTUorBjEjvZKZ"
end