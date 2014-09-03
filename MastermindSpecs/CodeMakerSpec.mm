#import "CodeMaker.h"
#define EXP_SHORTHAND
#import "Expecta.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CodeMakerSpec)

describe(@"CodeMaker", ^{
    __block CodeMaker *subject;

    beforeEach(^{
        subject = [[CodeMaker alloc] init];
    });
    
    it(@"should generate a 4 character code", ^{
        expect([[subject generateCode] length]).to.equal(4);
    });
});

SPEC_END
