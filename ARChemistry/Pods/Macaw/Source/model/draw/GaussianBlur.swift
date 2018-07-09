open class GaussianBlur: Effect {

    open let r: Double

    public init(r: Double = 0, input: Effect? = nil) {
        self.r = r
        super.init(input: input)
    }
}
